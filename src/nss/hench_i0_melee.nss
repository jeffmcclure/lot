/*

    Henchman Inventory And Battle AI

    This file contains a modified form of the original TalentMeleeAttack.
    Major modification to not randomly pick feats to use.

*/

#include "hench_i0_equip"


// void main() {    }


int GetItemAttackBonus(object oItem)
{
    itemproperty oProp;
    int itemPropType;
    int itemPropValue;
    int nReturnVal;
    
    oProp = GetFirstItemProperty(oItem);
    while (GetIsItemPropertyValid(oProp))
    {
        itemPropType = GetItemPropertyType(oProp);
        if (itemPropType == ITEM_PROPERTY_ENHANCEMENT_BONUS || itemPropType == ITEM_PROPERTY_ATTACK_BONUS)
        {
            itemPropValue = GetItemPropertyCostTableValue(oProp);
            if (itemPropValue > nReturnVal)
            {
                nReturnVal = itemPropValue;
            }            
        }
        oProp = GetNextItemProperty(oItem);                
    }
    return nReturnVal;
}


int GetMeleeAttackBonus(object oTarget = OBJECT_SELF)
{
    int nReturn = 0;
    // Primary weapon...if enchanted, add a few on.
    object oWeaponRight = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oTarget);
    
    // Finesse only if we are using a proper weapon
    int nStrMod = GetAbilityModifier(ABILITY_STRENGTH, oTarget);
    int nDexMod = GetAbilityModifier(ABILITY_DEXTERITY, oTarget);
    int bCanFinesse = GetHasFeat(FEAT_WEAPON_FINESSE) && (nDexMod > nStrMod);

    if (GetIsObjectValid(oWeaponRight))
    {        
        nReturn += GetItemAttackBonus(oWeaponRight);
        if (bCanFinesse)
        {
            switch (GetBaseItemType(oWeaponRight))
            {
                // only these weapons can be finessed
            case BASE_ITEM_DAGGER:
            case BASE_ITEM_HANDAXE:
            case BASE_ITEM_KAMA:
            case BASE_ITEM_KUKRI:
            case BASE_ITEM_LIGHTCROSSBOW:
            case BASE_ITEM_LIGHTHAMMER:
            case BASE_ITEM_LIGHTMACE:
            case BASE_ITEM_RAPIER:
            case BASE_ITEM_SHORTSWORD:
            case BASE_ITEM_SHURIKEN:
            case BASE_ITEM_SICKLE:
            case BASE_ITEM_SLING:
            case BASE_ITEM_THROWINGAXE:
                break;
            default:
                bCanFinesse = FALSE;
            }            
        }
    }
    else
    {
            // note creature weapons can be finessed
        oWeaponRight = GetItemInSlot(INVENTORY_SLOT_CWEAPON_R, oTarget);
        if (GetIsObjectValid(oWeaponRight))
        {        
            nReturn += GetItemAttackBonus(oWeaponRight);
        }
        else
        {        
            oWeaponRight = GetItemInSlot(INVENTORY_SLOT_ARMS, oTarget);
            if (GetIsObjectValid(oWeaponRight))
            {
                nReturn += GetItemAttackBonus(oWeaponRight);           
            }
        }
    }
    object oWeaponLeft = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oTarget);
    int nOffHandWeaponSize = GetMeleeWeaponSize(oWeaponLeft);
    if (nOffHandWeaponSize > 0)
    {
        if (nOffHandWeaponSize == GetCreatureSize(oTarget))
        {
            nReturn -= 2;
        }
        else
        {
            // TODO more could be done here
            nReturn -= 4;
        }
    }
    if(bCanFinesse)
    {
        nReturn += nDexMod;
    }
    else
    {
        nReturn += nStrMod;
    }
    return nReturn;
}


int GetRangeAttackBonus(object oTarget = OBJECT_SELF)
{
    int nReturn = 0;
    // Primary weapon...if enchanted, add a few on.
    object oWeaponRight = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oTarget);
    if (GetIsObjectValid(oWeaponRight))
    {        
        nReturn += GetItemAttackBonus(oWeaponRight);
    }        
    int nDexMod = GetAbilityModifier(ABILITY_DEXTERITY, oTarget);
    int nWisMod = GetAbilityModifier(ABILITY_WISDOM, oTarget);
    if (GetHasFeat(FEAT_ZEN_ARCHERY) && (nWisMod > nDexMod) && GetWeaponRanged(oWeaponRight))
    {
        nReturn += nWisMod;
    }
    else
    {
        nReturn += nDexMod;
    }    
    return nReturn;
}


int GetAttackBonus(object oCreature)
{
    object oRightWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oCreature);
    int bRangedWeapon = GetWeaponRanged(oRightWeapon);
    if (bRangedWeapon)
    {
        return GetRangeAttackBonus(oCreature);
    }
    return GetMeleeAttackBonus(oCreature);
}


// MELEE ATTACK OTHERS
/*
    ISSUE 1: Talent Melee Attack should set the Last Spell Used to 0 so that melee casters can use
    a single special ability.

    Auldar: Made changes here to use Taunt when appropriate as well as more accurate calculations for
    To-Hit vs Target AC.

    Tony: Made major changes in using attack feats. Heavily modified code from Jasperre.
*/

int HenchTalentMeleeAttack(object oIntruder, float fThresholdDistance, int iMeleeAttackers, int iCreatureType, int bPolymorphed)
{
    object oTarget = oIntruder;

    if (iCreatureType == 0)
    {
       MonsterBattleCry();
    }
    else if (iCreatureType == 1)
    {
       HenchBattleCry();
    }
    
    object oRightWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND);
    int bRangedWeapon = GetWeaponRanged(oRightWeapon);
    
    // allow sneak attack to use other feats
    if(GetHasFeat(FEAT_SNEAK_ATTACK))
    {        
            //Sneak Attack Flanking attack
        float fRange = iMeleeAttackers ? 3.5 : bRangedWeapon ? 50.0 : 5.0;
        int iEnemyAC, iAC = 100;
        object oRealMaster = GetRealMaster();
        int bEnemyMaster = FALSE;
        object oLastSneakTarget = GetLocalObject(OBJECT_SELF, "LastSneakTarget");
        object oAttackTarget;
        int nCnt = 1;
        object oEnemy = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, nCnt, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_IS_ALIVE, TRUE);
        object oBest = OBJECT_INVALID;
        while(GetIsObjectValid(oEnemy) && GetDistanceToObject(oEnemy) <= fRange)
        {
            if(!GetPlotFlag(oEnemy) && !GetIsImmune(oEnemy, IMMUNITY_TYPE_SNEAK_ATTACK, OBJECT_SELF))
            {
                oAttackTarget = GetAttackTarget(oEnemy);
                if(oAttackTarget != OBJECT_SELF)
                {
                    if (oEnemy == oLastSneakTarget)
                    {
                        oBest = oEnemy;
                        break;
                    }
                    iEnemyAC = GetAC(oEnemy);
                    if (oAttackTarget == oRealMaster)
                    {
                        if (!bEnemyMaster)
                        {
                            bEnemyMaster = TRUE;
                            iAC = iEnemyAC;
                            oBest = oEnemy;
                        }
                        else if(iAC > iEnemyAC)
                        {
                            iAC = iEnemyAC;
                            oBest = oEnemy;
                        }
                    }
                    else if(iAC > iEnemyAC)
                    {
                        iAC = iEnemyAC;
                        oBest = oEnemy;
                    }
                }
            }
            nCnt++;
            oEnemy = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, nCnt, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_IS_ALIVE, TRUE);
        }

        if (GetIsObjectValid(oBest))
        {
            oTarget = oBest;
            SetLocalObject(OBJECT_SELF, "LastSneakTarget", oBest);
        }
    }

    HenchEquipAppropriateWeapons(oTarget, fThresholdDistance, iCreatureType == 1, bPolymorphed);

    int iAC = GetAC(oTarget);
    int iNewBAB = GetBaseAttackBonus(OBJECT_SELF) + 5 + d4(2);

    if(bRangedWeapon)
    {
//        iNewBAB += GetRangeAttackBonus();

//        if((iNewBAB - 2) >= iAC)
//        {
/*
            Tony K during testing it appears this doesn't work. Also found a reference in NWN forums about
            called shot not working for ranged
            // At a -2 to hit, this can disarm the arms or legs...speed or attack bonus
            if(d8() == 1 && GetHasFeat(FEAT_CALLED_SHOT) && !GetHasFeatEffect(FEAT_CALLED_SHOT, oTarget)
                && !GetIsImmune(oTarget, IMMUNITY_TYPE_CRITICAL_HIT, OBJECT_SELF))
            {
                ActionUseFeat(FEAT_CALLED_SHOT, oTarget);
                return TRUE;
            } */
            // This provides another attack, at -2 to hit
            // changed to always use if present
            
            if(GetHasFeat(FEAT_RAPID_SHOT))
            {
                int iItemType = GetBaseItemType(oRightWeapon);
                if (iItemType == BASE_ITEM_SHORTBOW || iItemType == BASE_ITEM_LONGBOW)
                {            
                    ActionUseFeat(FEAT_RAPID_SHOT, oTarget);
                    return TRUE;
                }
            }
//        }
        ActionAttack(oTarget);
        return TRUE;
    }
    iNewBAB += GetMeleeAttackBonus();
    
    float relativeChallenge;
    if (iCreatureType == 0)
    {
        // mosters always use best feat
        relativeChallenge = -10.0;             
    }
    else
    {
        relativeChallenge = iCreatureType == 1 ? IntToFloat(GetHitDice(OBJECT_SELF)) * HENCH_HITDICE_TO_CR : GetChallengeRating(OBJECT_SELF);
        relativeChallenge -= GetIsPC(oTarget) || GetAssociateType(oTarget) == ASSOCIATE_TYPE_HENCHMAN ?
            IntToFloat(GetHitDice(oTarget))  * HENCH_HITDICE_TO_CR : GetChallengeRating(oTarget);
    }    
    
    // For use against them evil pests! Top - one use only anyway.
    if(GetHasFeat(FEAT_SMITE_EVIL) && GetAlignmentGoodEvil(oTarget) == ALIGNMENT_EVIL &&
        relativeChallenge <= 2.0)
    {
        ActionUseFeat(FEAT_SMITE_EVIL, oTarget);
        return TRUE;
    }
    if(GetHasFeat(FEAT_SMITE_GOOD) && GetAlignmentGoodEvil(oTarget) == ALIGNMENT_GOOD &&
        relativeChallenge <= 2.0)
    {
        ActionUseFeat(FEAT_SMITE_GOOD, oTarget);
        return TRUE;
    }
    
    // * only the playable races have whirlwind attack
    // * Attempt to Use Whirlwind Attack
    if (GetHasFeat(FEAT_WHIRLWIND_ATTACK) && GetOKToWhirl(OBJECT_SELF))
    {
        int bNumberofAttackers = WhirlwindGetNumberOfMeleeAttackers(WHIRL_DISTANCE);
        if (bNumberofAttackers)
        {
            ActionUseFeat(FEAT_WHIRLWIND_ATTACK, OBJECT_SELF);
            return TRUE;
        }
    }    
        // TODO update for HoTU, dwarven defender (is same as barb rage?)
    if (relativeChallenge <= 2.0 && TryKiDamage(oIntruder))
    {
        return TRUE;
    }
    
    if (d6() == 1 && !GetIsImmune(oTarget, IMMUNITY_TYPE_CRITICAL_HIT, OBJECT_SELF) && (iNewBAB >= iAC))
    {
        int bHasQuiveringPalm = GetHasFeat(FEAT_QUIVERING_PALM);
        int bHasStunningFist = GetHasFeat(FEAT_STUNNING_FIST);
        int bHasSAP = GetHasFeat(FEAT_SAP);
        int bHasCalledShot = GetHasFeat(FEAT_CALLED_SHOT) && d3() == 1;
        if ((bHasQuiveringPalm || bHasStunningFist || bHasSAP || bHasCalledShot) &&
            relativeChallenge <= 2.0  &&
            (GetCharacterLevel(OBJECT_SELF) / 2 + 10 + GetAbilityModifier(ABILITY_WISDOM) >=
            GetFortitudeSavingThrow(oTarget) + 5 + Random(15)))
        {
            if (bHasQuiveringPalm && !GetIsObjectValid(oRightWeapon))
            {
                ActionUseFeat(FEAT_QUIVERING_PALM, oTarget);
                return TRUE;
            }
            if(!GetHasAnyEffect3(EFFECT_TYPE_STUNNED, EFFECT_TYPE_PARALYZE, EFFECT_TYPE_DAZED, oTarget))
            {
                if (bHasStunningFist)
                {
                    int iMod = iNewBAB;
                    if (GetIsObjectValid(oRightWeapon) || (GetLevelByClass(CLASS_TYPE_MONK) == 0))
                    {
                        iMod -= 4;
                    }
                    if (iMod >= iAC)
                    {
                        ActionUseFeat(FEAT_STUNNING_FIST, oTarget);
                        return TRUE;
                    }
                }
                // OK, not for PCs, but may be on an NPC. -4 Attack. Above the one below.
                if(bHasSAP)
                {
                    if((iNewBAB - 4) >= iAC)
                    {
                        ActionUseFeat(FEAT_SAP, oTarget);
                        return TRUE;
                    }
                }
                if (bHasCalledShot)
                {
                    // At a -2 to hit, this can disarm the arms or legs...speed or attack bonus
                    if(((iNewBAB - 2) >= iAC) && !GetHasFeatEffect(FEAT_CALLED_SHOT, oTarget))
                    {
                        ActionUseFeat(FEAT_CALLED_SHOT, oTarget);
                        return TRUE;
                    }
                }
            }
        }
    }
    
    int bHasImprovedKnockdown = GetHasFeat(FEAT_IMPROVED_KNOCKDOWN);
    if((bHasImprovedKnockdown || GetHasFeat(FEAT_KNOCKDOWN)) &&
        !GetIsImmune(oTarget, IMMUNITY_TYPE_KNOCKDOWN, OBJECT_SELF) &&
        !GetHasFeatEffect(FEAT_KNOCKDOWN, oTarget) &&
        !GetHasFeatEffect(FEAT_IMPROVED_KNOCKDOWN, oTarget))
    {
        // By far the BEST feat to use - knocking them down lets you freely attack them!
        // These return 1-5, based on size.
        int iOurSize = GetCreatureSize(OBJECT_SELF);
        int iTheirSize = GetCreatureSize(oTarget);
        if (bHasImprovedKnockdown)
        {
            iOurSize++;
        }
        int bUse = iOurSize > iTheirSize;
        if (!bUse && ((iOurSize + 1) >= iTheirSize))
        {
            int iMod = iNewBAB - 4;
                // check if one size larger
            if (iOurSize != iTheirSize)
            {
                iMod -= 4;
            }
            if(iMod >= iAC)
            {
                bUse = iMod > GetSkillRank(SKILL_DISCIPLINE, oTarget);
            }
        }
        if(bUse)
        {
            ActionUseFeat(bHasImprovedKnockdown ? FEAT_IMPROVED_KNOCKDOWN : FEAT_KNOCKDOWN, oTarget);
            return TRUE;
        }
    }
    // start using expertise if have under 50% hit points
    if (GetHasFeat(FEAT_EXPERTISE) && GetPercentageHPLoss(OBJECT_SELF) < 50)
    {        
        // get estimation of opponent attack vs. my AC
        int iMyAC = GetAC(OBJECT_SELF);
        int iTargetsBAB = GetBaseAttackBonus(oTarget) + 5 + d4(2) + GetAttackBonus(oTarget);
                
        if(GetHasFeat(FEAT_IMPROVED_EXPERTISE) && (iTargetsBAB - 5) >= iMyAC)
        {
            SetActionMode(OBJECT_SELF, ACTION_MODE_IMPROVED_EXPERTISE, TRUE);
            ActionAttack(oTarget);
            return TRUE;
        }
        if(iTargetsBAB >= iMyAC)
        {
            SetActionMode(OBJECT_SELF, ACTION_MODE_EXPERTISE, TRUE);
            ActionAttack(oTarget);
            return TRUE;
        }
    }

    // Only use parry on an active melee attacker, and
    // only if our parry skill > our AC - 10
/* TODO removed    object oEnemy = GetLastHostileActor();
    if (GetIsObjectValid(oEnemy) 
        && GetAttackTarget(oEnemy) == OBJECT_SELF 
        && GetIsMeleeAttacker(oEnemy)) 
    {
        int nParrySkill = GetSkillRank(SKILL_PARRY);
        int nAC = GetAC(OBJECT_SELF);
        if (nParrySkill > (nAC - 10) )
        {
            ActionUseSkill(SKILL_PARRY, oTarget);
            return TRUE;
        }
    } */

//
// Auldar: Give 10% chance to Taunt if target is within 3.5 meters and is a challenge, if Skill points have been
// spent in Taunt skill indicating intention to use, and a taunt isn't in effect
//
    if ((d10 () == 1) && ((relativeChallenge <= 2.0) ||
        (GetCharacterLevel(oTarget) > (GetCharacterLevel(OBJECT_SELF) - 2)))
        && (GetDistanceToObject(oTarget) <= 3.5))
    {
    // Auldar: Adding a check for the Taunt skill, and ensuring that noone with ONLY a CHA mod to
    // Taunt will use the skill.
    // This confirms that some points are spent in the skill indicating an intention for the NPC to use them.
    // Also using 69MEH69's idea to check for a negative modifier so we don't subtract a negative number (ie add)
    // to the skill check
        int chaCheck = GetAbilityModifier(ABILITY_CHARISMA);
        int tauCheck = GetSkillRank(SKILL_TAUNT);
        if (((tauCheck - chaCheck) > 0) && ((tauCheck + 5 + d4(2)) > GetSkillRank(SKILL_CONCENTRATION, oTarget)))
        {
            ActionUseSkill(SKILL_TAUNT, oTarget);
            return TRUE;
        }
    }
    
    object oTargetRightWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oTarget);
    if(d10() == 1 && (GetHasFeat(FEAT_IMPROVED_DISARM) || GetHasFeat(FEAT_DISARM)) &&
        GetIsObjectValid(oRightWeapon) && !GetWeaponRanged(oRightWeapon) && GetIsCreatureDisarmable(oTarget))
    {
        if ((GetIsObjectValid(oTargetRightWeapon) && !GetWeaponRanged(oTargetRightWeapon)) ||
            !GetIsObjectValid(oTargetRightWeapon))
        {
            int iWeaponSize = GetMeleeWeaponSize(oRightWeapon);
            int iTargetWeaponSize = GetMeleeWeaponSize(oTargetRightWeapon);

            // No AOO, and only a -4 penalty to hit.
            if(GetHasFeat(FEAT_IMPROVED_DISARM))
            {
                // Apply weapon size penalites/bonuses to check - Use right weapons.
                int iMod = iWeaponSize - iTargetWeaponSize;
                if(iMod != 0) iMod += (iMod * 4);
                if((iNewBAB - 4 + iMod) >= iAC)
                {
                    ActionUseFeat(FEAT_IMPROVED_DISARM, oTarget);
                    return TRUE;
                }
            }
            // Provokes an AOO. Improved does not, but this is -6, and bonuses depend on weapons used (sizes)
            else if(d2() == 1)
            {
                // Apply weapon size penalites/bonuses to check - Use right weapons.
                int iMod = iWeaponSize - iTargetWeaponSize;
                if(iMod != 0) iMod += (iMod * 4);
                if((iNewBAB - 6 + iMod) >= iAC)
                {
                    ActionUseFeat(FEAT_DISARM, oTarget);
                    return TRUE;
                }
            }
        }
    }

    // This activates an extra attack, at -2 to hit. Of course, only unarmed and kama
    if(GetHasFeat(FEAT_FLURRY_OF_BLOWS) && ((iNewBAB - 2) >= iAC) && (!GetIsObjectValid(oRightWeapon) ||
        (GetBaseItemType(oRightWeapon) == BASE_ITEM_KAMA)))
    {
        ActionUseFeat(FEAT_FLURRY_OF_BLOWS, oTarget);
        return TRUE;
    }
    // -10 to hit - make sure by extra 5
    if(GetHasFeat(FEAT_IMPROVED_POWER_ATTACK) && ((iNewBAB - 15) >= iAC))
    {
        ActionUseFeat(FEAT_IMPROVED_POWER_ATTACK, oTarget);
        return TRUE;
    }
    // is a -5 to hit - make sure by extra 5
    if(GetHasFeat(FEAT_POWER_ATTACK) && ((iNewBAB - 10) >= iAC))
    {
        ActionUseFeat(FEAT_POWER_ATTACK, oTarget);
        return TRUE;
    }
    // extra damage with only one attack    
    if (GetHasFeat(FEAT_DIRTY_FIGHTING) && GetBaseAttackBonus(OBJECT_SELF) < 8)
    {
        ActionUseFeat(FEAT_DIRTY_FIGHTING, oTarget);
        return TRUE;
    }
        
    ActionAttack(oTarget);
    return TRUE;
}
