/*

    Henchman Inventory And Battle AI

    This file routines are used for healing and curing conditions.
    Contains modified forms of the TalentCureCondition, TalentHealingSelf,
    and TalentHeal

*/

#include "hench_i0_spells"
#include "hench_i0_assoc"


// void main() {    }


object GetBestHealingKit()
{
    object oKit = OBJECT_INVALID;
    object oItem = GetFirstItemInInventory();
    int iRunningValue = 0;
    int iItemValue, iStackSize;
    while(GetIsObjectValid(oItem))
    {
        if(GetBaseItemType(oItem) == BASE_ITEM_HEALERSKIT)
        {
            iItemValue = GetGoldPieceValue(oItem);
            iStackSize = GetNumStackedItems(oItem);
            // Stacked kits be worth what they should be seperatly.
            iItemValue = iItemValue/iStackSize;
            if(iItemValue > iRunningValue)
            {
                iRunningValue = iItemValue;
                oKit = oItem;
            }
        }
        oItem = GetNextItemInInventory();
    }
    return oKit;
}



int ReturnHealingInfo(int iSpellID, int iHealAmount = FALSE)
{
    switch(iSpellID)
    {
// RANK - NAME = D8 AMOUNTs + RANGE OF CLERIC LEVELS ADDED. MAX. AVERAGE OF DICE. ABOUT 2/3 OF MODIFIERS.
    case SPELL_CURE_MINOR_WOUNDS:
    case SPELL_INFLICT_MINOR_WOUNDS:
        //  Max of 4. Take as 4. Take modifiers as 0.
        return iHealAmount ? 4 : 1;
    case SPELL_CURE_LIGHT_WOUNDS:
    case SPELLABILITY_LESSER_BODY_ADJUSTMENT:
    case SPELL_INFLICT_LIGHT_WOUNDS:
        // 1d8 + 1-5. Max of 8. Take as 6. Take modifiers as 3.
        return iHealAmount ? 9 : 2;
    case SPELL_CURE_MODERATE_WOUNDS:
    case SPELL_INFLICT_MODERATE_WOUNDS:
        // 2d8 + 3-10. Max of 16. Take as 12. Take modifiers as 5.
        return iHealAmount ? 17 : 3;
    break;
    case SPELL_CURE_SERIOUS_WOUNDS:
    case SPELL_INFLICT_SERIOUS_WOUNDS:
        // 3d8 + 5-15. Max of 24. Take as 18. Take modifiers as 7.
        return iHealAmount ? 25 : 4;
    case SPELL_CURE_CRITICAL_WOUNDS:
    case SPELL_INFLICT_CRITICAL_WOUNDS:
    case SPELL_HENCH_Cure_Critical_Wounds_Others:
        //  4d8 + 7-20. Max of 32. Take as 24. Take modifiers as 10.
        return iHealAmount ? 34 : 5;
    case SPELL_HEALING_CIRCLE:
    case SPELL_NEGATIVE_ENERGY_BURST:
    case SPELL_CIRCLE_OF_DOOM:
        // 1d8 + 9-20. Max of 8. Take as 8. Take modifiers as 10.
        return iHealAmount ? 18 : 4;
    case SPELL_HEAL:
    case SPELL_MASS_HEAL:
    case SPELL_HARM:
    case SPELL_HENCH_UndeadSelfHarm:
        // max out for heal spells
        return iHealAmount ? 1000 : 6;
    case SPELL_NEGATIVE_ENERGY_RAY:
        // ((casterlevel +  2) / 2)d6.
        return iHealAmount ? 18 : 2;
    }
    // On error - return 0 rank, or 0 heal.
    return FALSE;
}


/*::///////////////////////////////////////////////
   HEAL SELF WITH POTIONS AND SPELLS
    Uses the best it can.
    1. If it is heal, they need to be under half HP and under 40 HP
    2. If not, it has to be under half HP and not be heal/mass heal
    3. Testing to see if harm will be cast by undead
//::////////////////////////////////////////////*/
int TalentHealingImpl(object oHeal, int iCurEffects, int bForce)
{
    int iCurrent = GetCurrentHitPoints(oHeal);
    int iBase = GetMaxHitPoints(oHeal);
    int iCanHeal = bForce;
    if (iCurrent == iBase)
    {
        return FALSE;
    }
    // If current is under 1/2
    int iRace = GetRacialType(oHeal);
    
    if ((bForce || (iCurrent < iBase / 2))/* && iRace != RACIAL_TYPE_CONSTRUCT*/)
    {
        int bIsSelf = (oHeal == OBJECT_SELF);
        if (bIsSelf)
        {
            // reset flag to assume will find healing
            SetLocalInt(OBJECT_SELF, "INeedHealing", 1);
        }
        int iBeBelow =  iBase - iCurrent;
        
        talent tHealBest;
        int bUseTalent = FALSE;
        int iHealRank = 0;
        int iHealSpell = 0;
        if (iRace != RACIAL_TYPE_UNDEAD)
        {
            // If we can heal self with feats...use them! No AOO
            if(bIsSelf && GetHasFeat(FEAT_WHOLENESS_OF_BODY))
            {
                iCanHeal = TRUE;
                if (iBeBelow >= GetLevelByClass(CLASS_TYPE_MONK, OBJECT_SELF) * 2)
                {
                    ActionUseFeat(FEAT_WHOLENESS_OF_BODY, OBJECT_SELF);
                    return TRUE;
                }
            }
            if(GetHasFeat(FEAT_LAY_ON_HANDS))
            {
                iCanHeal = TRUE;
               // This does the actual formula...note, putting ones to stop DIVIDE BY ZERO errors
                int nChr = GetAbilityModifier(ABILITY_CHARISMA);
                    if(nChr < 1) nChr = 1;
                int nLevel = GetLevelByClass(CLASS_TYPE_PALADIN) + GetLevelByClass(CLASS_TYPE_DIVINECHAMPION);
                    if(nLevel < 1) nLevel = 1;
                //Caluclate the amount needed to be at, to use.
                int nHeal = nLevel * nChr;
                if(nHeal <= 0) nHeal = 1;
                if(iBeBelow >= nHeal)
                {
                    ActionUseFeat(FEAT_LAY_ON_HANDS, oHeal);
                    return TRUE;
                }
            }
            // Note: Feat Lesser Bodily Adjustment uses cure light wounds spell script.
            // Odd classes mean no potions or healing kits.
            int bUseItems = GetIsObjectValid(GetRealMaster()) || GetCreatureUseItems(OBJECT_SELF);
            int iPotionOrItemBoost = nGlobalMeleeAttackers ? 2 : 0;
            
            // Lets see if we can use a healing kit! Only a valid race (as potions)
            if (!(iCurEffects & HENCH_HAS_POLYMORPH_EFFECT))
            {
                if(bUseItems && GetSkillRank(SKILL_HEAL) > 0)
                {
                    object oHealingKit = GetBestHealingKit();
                    if(GetIsObjectValid(oHealingKit))
                    {
                        ActionUseSkill(SKILL_HEAL, oHeal, 0, oHealingKit);
                        return TRUE;
                    }
                }

                if (GetHasFixedSpell(SPELL_MASS_HEAL))
                {
                    iHealSpell = SPELL_MASS_HEAL;   
                }
                else if (GetHasFixedSpell(SPELL_HEAL))
                {
                    iHealSpell = SPELL_HEAL;   
                }
                else if (GetHasFixedSpell(SPELL_CURE_CRITICAL_WOUNDS))
                {
                    iHealSpell = SPELL_CURE_CRITICAL_WOUNDS;   
                }
                else if (GetHasFixedSpell(SPELL_HEALING_CIRCLE))
                {
                    iHealSpell = SPELL_HEALING_CIRCLE;   
                }
                else if (GetHasFixedSpell(SPELL_HENCH_Cure_Critical_Wounds_Others))
                {
                    iHealSpell = SPELL_HENCH_Cure_Critical_Wounds_Others;   
                }
                else if (GetHasFixedSpell(SPELL_CURE_SERIOUS_WOUNDS))
                {
                    iHealSpell = SPELL_CURE_SERIOUS_WOUNDS;   
                }
                else if (GetHasFixedSpell(SPELL_CURE_MODERATE_WOUNDS))
                {
                    iHealSpell = SPELL_CURE_MODERATE_WOUNDS;   
                }
                else if (GetHasFixedSpell(SPELLABILITY_LESSER_BODY_ADJUSTMENT))
                {
                    iHealSpell = SPELLABILITY_LESSER_BODY_ADJUSTMENT;   
                }
                else if (GetHasFixedSpell(SPELL_CURE_LIGHT_WOUNDS))
                {
                    iHealSpell = SPELL_CURE_LIGHT_WOUNDS;   
                }
                else if (GetHasFixedSpell(SPELL_CURE_MINOR_WOUNDS))
                {
                    iHealSpell = SPELL_CURE_MINOR_WOUNDS;   
                }
                iHealRank = ReturnHealingInfo(iHealSpell);
            }
            
            if (bIsSelf && (bUseItems || (iCurEffects & HENCH_HAS_POLYMORPH_EFFECT)))
            {
                talent tPotionHeal = GetCreatureTalentBest(TALENT_CATEGORY_BENEFICIAL_HEALING_POTION, 20);
                int iPotionValid = GetIsTalentValid(tPotionHeal);
                if (iPotionValid)
                {
                    int iTestSpell = GetIdFromTalent(tPotionHeal);
                    int iTestRank = ReturnHealingInfo(iTestSpell) + iPotionOrItemBoost;
                    if (iTestRank > iHealRank)
                    {
                        iHealRank = iTestRank;
                        iHealSpell = iTestSpell;
                        tHealBest = tPotionHeal;
                        bUseTalent = TRUE;
                    }
                }
            }
        }
        else
        {
            if (GetHasFixedSpell(SPELL_HARM))
            {
                iHealSpell = SPELL_HARM;   
            }
            else if (GetHasSpell(SPELL_HENCH_UndeadSelfHarm))
            {
                iHealSpell = SPELL_HENCH_UndeadSelfHarm;   
            }
            else if (GetHasFixedSpell(SPELL_INFLICT_CRITICAL_WOUNDS))
            {
                iHealSpell = SPELL_INFLICT_CRITICAL_WOUNDS;   
            }
            else if (GetHasFixedSpell(SPELL_INFLICT_SERIOUS_WOUNDS))
            {
                iHealSpell = SPELL_INFLICT_SERIOUS_WOUNDS;   
            }
            else if (GetHasFixedSpell(SPELL_NEGATIVE_ENERGY_BURST))
            {
                iHealSpell = SPELL_NEGATIVE_ENERGY_BURST;   
            }
            else if (GetHasFixedSpell(SPELL_CIRCLE_OF_DOOM))
            {
                iHealSpell = SPELL_CIRCLE_OF_DOOM;   
            }
            else if (GetHasFixedSpell(SPELL_INFLICT_MODERATE_WOUNDS))
            {
                iHealSpell = SPELL_INFLICT_MODERATE_WOUNDS;   
            }
            else if (!bIsSelf && GetHasFixedSpell(SPELL_NEGATIVE_ENERGY_RAY))
            {
                iHealSpell = SPELL_NEGATIVE_ENERGY_RAY;   
            }
            else if (GetHasFixedSpell(SPELL_INFLICT_LIGHT_WOUNDS))
            {
                iHealSpell = SPELL_INFLICT_LIGHT_WOUNDS;   
            }
            else if (GetHasFixedSpell(SPELL_INFLICT_MINOR_WOUNDS))
            {
                iHealSpell = SPELL_INFLICT_MINOR_WOUNDS;   
            }            
            iHealRank = ReturnHealingInfo(iHealSpell);
        }

           // heal spell
        if ((iHealSpell == SPELL_HEAL) || (iHealSpell == SPELL_MASS_HEAL) || (iHealSpell == SPELL_HARM) || (iHealSpell == SPELL_HENCH_UndeadSelfHarm))
        {
            iCanHeal = TRUE;
            if (bForce || (iCurrent < 40) || (iCurrent < (iBase / 3)))
            {
                if (!bForce && nGlobalMeleeAttackers)
                {
                    HenchTalentHide(iCurEffects, nGlobalMeleeAttackers);
                }
                if (bUseTalent)
                {
                    ActionUseTalentOnObject(tHealBest, oHeal);
                }
                else if (iHealSpell == SPELL_HENCH_UndeadSelfHarm)
                {                    
                    ActionCastSpellAtObject(SPELL_HENCH_UndeadSelfHarm, oHeal);                    
                }
                else
                {
                    CastFixedSpellOnObject(iHealSpell, oHeal, iHealSpell == SPELL_MASS_HEAL ? 8 : 6);
                }
                return TRUE;
            }
        }
            // other cure spell
        else if (iHealRank > 0)
        {
            iCanHeal = TRUE;
            int iDamageNeededToBeDone = ReturnHealingInfo(iHealSpell, TRUE);
                // If the current HP is under the damage that is healed.
            if(bForce || (iCurrent <= iBase - iDamageNeededToBeDone) || (iCurrent < ((iBase * 2) / 5)))
            {
                if (!bForce && nGlobalMeleeAttackers)
                {
                    HenchTalentHide(iCurEffects, nGlobalMeleeAttackers);
                }
                if (bUseTalent)
                {
                    ActionUseTalentOnObject(tHealBest, oHeal);
                }
                else
                {
                    // TODO spell level
                    CastFixedSpellOnObject(iHealSpell, oHeal, iHealRank - 1);
                }
                return TRUE;
            }
        }
        if (bIsSelf && !iCanHeal)
        {
            // indicate that unable to heal
            SetLocalInt(OBJECT_SELF, "INeedHealing", 2);
        }
    }

    return FALSE;
}


// HEAL ALL ALLIES
// Only if they are in sight, and are under 50%. Always nearest...
// Also, it casts AOE healing spells as well!
int TalentHealNearestAlly(int iHasAlly, int iCurEffects, int bForce)
{
    object oTarget = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND, OBJECT_SELF, 1, CREATURE_TYPE_IS_ALIVE, FALSE, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN);
    if(GetIsObjectValid(oTarget) && (GetGeneralOptions(HENCH_GENAI_ENABLERAISE) & HENCH_GENAI_ENABLERAISE))
    {
        if(GetIsDead(oTarget))
        {
            if (GetHasFixedSpell(SPELL_RESURRECTION))
            {
                CastFixedSpellOnObject(SPELL_RESURRECTION, oTarget, 7);
                return TRUE;
            }
            if (GetHasFixedSpell(SPELL_RAISE_DEAD))
            {
                CastFixedSpellOnObject(SPELL_RAISE_DEAD, oTarget, 5);
                return TRUE;
            }
        }
    }
    if(iHasAlly)
    {
        int nCurrent, nAdjusted;
        int nBase;        
        
        // * change target
        // * find nearest friend to heal.        
        object oTarget = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND);
        int i = 0;
        object oMaster = GetMaster(OBJECT_SELF);
        
        object oHeal = OBJECT_INVALID;
        int nMaxDiff = 0;        
        int nAssocType, nDiff;
        int nRacialType;
        object oUndead = OBJECT_INVALID;
        int nMaxUndeadDiff = 0;        
        
        while (GetIsObjectValid(oTarget) && GetDistanceToObject(oTarget) < 20.0)
        {
            nCurrent = GetCurrentHitPoints(oTarget);
            if (bForce)
                nAdjusted = GetCurrentHitPoints(oTarget);
            else
                nAdjusted = GetCurrentHitPoints(oTarget) * 2;
                
            nBase = GetMaxHitPoints(oTarget);
            nAssocType = GetAssociateType(oTarget);
            // note : ignore dominated creatures
            if (nAdjusted < nBase && oTarget != OBJECT_SELF && oTarget != oMaster &&
                !GetIsDead(oTarget) && GetAssociateType(oTarget) != ASSOCIATE_TYPE_DOMINATED)
            {
                nDiff = nBase - nCurrent;
                // summoned don't count as much
                if (nAssocType == ASSOCIATE_TYPE_SUMMONED)
                {                    
                    nDiff *= 3;
                    nDiff /= 4;
                }                
                nRacialType = GetRacialType(oTarget);                
                if (nRacialType == RACIAL_TYPE_UNDEAD)
                {
                    if (nDiff > nMaxUndeadDiff)
                    {
                        nMaxUndeadDiff = nDiff;
                        oUndead = oTarget;                    
                    }
                }
                else
                {
                    if (nDiff > nMaxDiff)
                    {
                        nMaxDiff = nDiff;
                        oHeal = oTarget;                    
                    }
                }
            }
            i++;
            oTarget = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND, OBJECT_SELF, i);
        }        
        if (nMaxDiff > nMaxUndeadDiff && GetIsObjectValid(oHeal))
        {
            if (TalentHealingImpl(oHeal, iCurEffects, bForce))
            {
                return TRUE;
            }
        }
        if (GetIsObjectValid(oUndead))
        {
            if (TalentHealingImpl(oUndead, iCurEffects, bForce))
            {
                return TRUE;
            }
        }
        if (nMaxDiff <= nMaxUndeadDiff && GetIsObjectValid(oHeal))
        {
            if (TalentHealingImpl(oHeal, iCurEffects, bForce))
            {
                return TRUE;
            }
        }
        
     }
     return FALSE;
}


// HEAL SELF WITH POTIONS AND SPELLS
int HenchTalentHealingSelf(int iCurEffects, int nForce)
{
    return TalentHealingImpl(OBJECT_SELF, iCurEffects, nForce);
}


// HEAL ALL ALLIES
int HenchTalentHeal(int iCurEffects, int bForce)
{
    talent tUse;
    int nCurrent = GetCurrentHitPoints(OBJECT_SELF) * 2;
    int nBase = GetMaxHitPoints(OBJECT_SELF);
    int nCR;

    object oRealMaster = GetRealMaster();

    if((GetAssociateHealMaster() || bForce) && !GetIsDead(oRealMaster))
    {
        if (TalentHealingImpl(oRealMaster, iCurEffects, TRUE))
        {
            return TRUE;
        }
    }
    if(nCurrent < nBase)
    {
        if (TalentHealingImpl(OBJECT_SELF, iCurEffects, FALSE))
        {
            return TRUE;
        }
    }
    if (!bForce)
    {
        return TalentHealNearestAlly(TRUE, iCurEffects, FALSE);
    }
    return FALSE;
}


/*::///////////////////////////////////////////////
   CURE SELF FULLY WITH POTIONS AND SPELLS
    Uses the best healing at the mo. Heals self out of battle...
    No area of effect spells at the moment. Works OK...
//::////////////////////////////////////////////*/
// CURE DISEASE, POISON ETC

const int nCurse = 0x00000001;
const int nPoison = 0x00000002;
const int nDisease = 0x00000004;
const int nAbilityDrain = 0x00000008;
const int nDrained = 0x00000010;
const int nBlindDeaf = 0x00000020;
const int nParalsis = 0x00000040;
const int nSlow = 0x00000080;
const int nFreedom = 0x00000100;
const int nFear = 0x00000200;
const int nClarity = 0x00000400;
const int nDarkness = 0x00000800;
const int nSleep = 0x00001000;
const int nPetrified = 0x00002000;
const int nDominated = 0x00004000;


int TalentCureConditionAllAllies(int iAlly)
{
    effect eEffect;
    if(iAlly)
    {
        location lSelf = GetLocation(OBJECT_SELF);
        // Using this, until I can make it work on myself then nearest creatures, which should be better.
        // TODO change loop, order by importance.
        object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lSelf);
        int nSum;
        int nDispelSum;

        while(GetIsObjectValid(oTarget))
        {
            nSum = 0;
            nDispelSum = 0;
            if(!GetIsDead(oTarget) && GetIsFriend(oTarget) && GetAssociateType(oTarget) != ASSOCIATE_TYPE_DOMINATED)
            {
                eEffect = GetFirstEffect(oTarget);

                while(GetIsEffectValid(eEffect))
                {
                    int nType = GetEffectType(eEffect);
                    int nNewSum = 0;

                    if(nType == EFFECT_TYPE_DISEASE)
                    {
                       nNewSum = nDisease;
                    }
                    else if(nType == EFFECT_TYPE_FRIGHTENED)
                    {
                        nNewSum = nFear;
                    }
                    else if(nType == EFFECT_TYPE_POISON)
                    {
                        nNewSum = nPoison;
                    }
                    else if(nType == EFFECT_TYPE_CURSE)
                    {
                        nNewSum = nCurse;
                    }
                    else if(nType == EFFECT_TYPE_NEGATIVELEVEL)
                    {
                        nNewSum = nDrained;
                    }
                    else if(nType == EFFECT_TYPE_ABILITY_DECREASE ||
                            nType == EFFECT_TYPE_AC_DECREASE ||
                            nType == EFFECT_TYPE_ATTACK_DECREASE ||
                            nType == EFFECT_TYPE_DAMAGE_DECREASE ||
                            nType == EFFECT_TYPE_DAMAGE_IMMUNITY_DECREASE ||
                            nType == EFFECT_TYPE_SAVING_THROW_DECREASE ||
                            nType == EFFECT_TYPE_SPELL_RESISTANCE_DECREASE ||
                            nType == EFFECT_TYPE_SKILL_DECREASE)
                    {
                        nNewSum = nAbilityDrain;
                    }
                    else if(nType == EFFECT_TYPE_PARALYZE)
                    {
                        nNewSum = nParalsis;
                    }
                    else if(nType == EFFECT_TYPE_SLOW)
                    {
                        nNewSum = nSlow;
                    }
                    else if(nType == EFFECT_TYPE_CHARMED ||
                            nType == EFFECT_TYPE_DAZED ||
                            nType == EFFECT_TYPE_CONFUSED ||
                            nType == EFFECT_TYPE_STUNNED)
                    {
                        nNewSum = nClarity;
                    }
                    else if(nType == EFFECT_TYPE_BLINDNESS || nType == EFFECT_TYPE_DEAF)
                    {
                        nNewSum = nBlindDeaf;
                    }
                    else if(nType == EFFECT_TYPE_ENTANGLE ||
                            nType == EFFECT_TYPE_MOVEMENT_SPEED_DECREASE)
                    {
                        nNewSum = nFreedom;
                    }
                    else if(nType == EFFECT_TYPE_SLEEP)
                    {
                        nNewSum = nSleep;
                    }
                    else if(nType == EFFECT_TYPE_DARKNESS)
                    {
                        if (!GetHasSpellEffect(SPELL_DARKVISION, oTarget) &&
                            !GetHasSpellEffect(SPELL_TRUE_SEEING, oTarget) &&
                            !GetCreatureHasItemProperty(ITEM_PROPERTY_TRUE_SEEING, oTarget))
                        {
                            nNewSum = nDarkness;
                        }
                    }
                    else if(nType == EFFECT_TYPE_PETRIFY)
                    {
                        nNewSum = nPetrified;
                    }                    
                    nSum = nSum | nNewSum;
                    if (GetEffectSubType(eEffect) == SUBTYPE_MAGICAL)
                    {
                        nDispelSum = nDispelSum | nNewSum;
                    }                    
                    // TODO feeblemind and bane cured by mind blank                    
                    eEffect = GetNextEffect(oTarget);
                }
            }
            else if (!GetIsDead(oTarget) && !GetIsFriend(oTarget) && GetAssociateType(oTarget) == ASSOCIATE_TYPE_DOMINATED &&
                (GetMaster(OBJECT_SELF) == oTarget || GetMaster(OBJECT_SELF) == GetMaster(oTarget) || GetFactionEqual(oTarget, OBJECT_SELF)))
            {
                eEffect = GetFirstEffect(oTarget);
                while(GetIsEffectValid(eEffect))
                {
                    int nType = GetEffectType(eEffect);

                    eEffect = GetNextEffect(oTarget);
                    if(nType == EFFECT_TYPE_DOMINATED)
                    {
                    // this condition only turn on one bit
                        nSum = nDominated;
                        if (GetEffectSubType(eEffect) == SUBTYPE_MAGICAL)
                        {
                            nDispelSum = nDominated;
                        }
                        break;
                    }
                }
            }
            if(nSum != 0)
            {
                if (GetLocalInt(OBJECT_SELF, "X2_HENCH_DO_NOT_DISPEL"))
                {
                    nDispelSum = 0;
                }
                int bNotIsSelf = oTarget != OBJECT_SELF;
                // only use dispel for some effects
                nDispelSum = nDispelSum & (nClarity | nFear | nDominated | nParalsis);                
                    // do this one first
                if (nSum == nDominated)
                {                    
                    if (GetHasFixedSpell(SPELL_MIND_BLANK) && !(bFoundPotionOnly && bNotIsSelf))
                    {
                        CastFixedSpellOnObject(SPELL_MIND_BLANK, oTarget, 8);
                        return TRUE;
                    }
                    if (GetHasFixedSpell(SPELL_LESSER_MIND_BLANK) && !(bFoundPotionOnly && bNotIsSelf))
                    {
                        CastFixedSpellOnObject(SPELL_LESSER_MIND_BLANK, oTarget, 5);
                        return TRUE;
                    }
                    if (GetHasFixedSpell(SPELL_GREATER_RESTORATION) && !(bFoundPotionOnly && bNotIsSelf))
                    {
                        CastFixedSpellOnObject(SPELL_GREATER_RESTORATION, oTarget, 7);
                        return TRUE;
                    }
                }
                if (nDispelSum == nDominated)
                {                    
                    if (GetHasFixedSpell(SPELL_GREATER_DISPELLING) && !(bFoundPotionOnly && bNotIsSelf))
                    {
                        CastFixedSpellOnObject(SPELL_GREATER_DISPELLING, oTarget, 6);
                        return TRUE;
                    }
                    if (GetHasFixedSpell(SPELL_DISPEL_MAGIC) && !(bFoundPotionOnly && bNotIsSelf))
                    {
                        CastFixedSpellOnObject(SPELL_DISPEL_MAGIC, oTarget, 3);
                        return TRUE;
                    }
                    if (GetHasFixedSpell(SPELL_LESSER_DISPEL) && !(bFoundPotionOnly && bNotIsSelf))
                    {
                        CastFixedSpellOnObject(SPELL_LESSER_DISPEL, oTarget, 2);
                        return TRUE;
                    }
                }
                   // test for single effect or fear (only remove fear works)
                // i.e. don't waste good spells                
                if (nSum & nPetrified)
                {
                    if ((GetHasFixedSpell(SPELL_STONE_TO_FLESH) && !(bFoundPotionOnly && bNotIsSelf)))
                    {
                        CastFixedSpellOnObject(SPELL_STONE_TO_FLESH, oTarget, 6);
                        return TRUE;
                    }
                    else
                    {
                        nSum = 0;   
                    }
                }
                if((nSum & nFear) && (GetHasFixedSpell(SPELL_REMOVE_FEAR) && !(bFoundPotionOnly && bNotIsSelf)))
                {
                    CastFixedSpellOnObject(SPELL_REMOVE_FEAR, oTarget, 1);
                    return TRUE;
                }
                if((nSum == nDisease) && (GetHasFixedSpell(SPELL_REMOVE_DISEASE) && !(bFoundPotionOnly && bNotIsSelf)))
                {
                    CastFixedSpellOnObject(SPELL_REMOVE_DISEASE, oTarget, 3);
                    return TRUE;
                }
                if(((nSum & ~(nDisease | nPoison)) == 0) && (GetHasFixedSpell(SPELL_NEUTRALIZE_POISON) && !(bFoundPotionOnly && bNotIsSelf)))
                {
                    CastFixedSpellOnObject(SPELL_NEUTRALIZE_POISON, oTarget, 3);
                    return TRUE;
                }
                if((nSum == nCurse) && (GetHasFixedSpell(SPELL_REMOVE_CURSE) && !(bFoundPotionOnly && bNotIsSelf)))
                {
                    CastFixedSpellOnObject(SPELL_REMOVE_CURSE, oTarget, 3);
                    return TRUE;
                }
                if((nSum == nBlindDeaf) && (GetHasFixedSpell(SPELL_REMOVE_BLINDNESS_AND_DEAFNESS) && !(bFoundPotionOnly && bNotIsSelf)))
                {
                    CastFixedSpellOnObject(SPELL_REMOVE_BLINDNESS_AND_DEAFNESS, oTarget, 3);
                    return TRUE;
                }
                if((nSum == nParalsis) && (GetHasFixedSpell(SPELL_REMOVE_PARALYSIS)  && !(bFoundPotionOnly && bNotIsSelf)))
                {
                    CastFixedSpellOnObject(SPELL_REMOVE_PARALYSIS, oTarget, 2);
                    return TRUE;
                }
                if((nSum == nAbilityDrain) && GetHasFixedSpell(SPELL_LESSER_RESTORATION) && !(bFoundPotionOnly && bNotIsSelf))
                {
                    CastFixedSpellOnObject(SPELL_LESSER_RESTORATION, oTarget, 2);
                    return TRUE;
                }
                if(((nSum & ~(nParalsis | nFreedom | nSlow)) == 0) && (GetHasFixedSpell(SPELL_FREEDOM_OF_MOVEMENT) && !(bFoundPotionOnly && bNotIsSelf)))
                {
                    CastFixedSpellOnObject(SPELL_FREEDOM_OF_MOVEMENT, oTarget, 4);
                    return TRUE;
                }
                if((nSum & ~(nClarity | nSleep | nSlow)) == 0)
                {
                    if (GetHasFixedSpell(SPELL_MIND_BLANK) && !(bFoundPotionOnly && bNotIsSelf))
                    {
                        CastFixedSpellOnObject(SPELL_MIND_BLANK, oTarget, 8);
                        return TRUE;
                    }
                    if (GetHasFixedSpell(SPELL_LESSER_MIND_BLANK) && !(bFoundPotionOnly && bNotIsSelf))
                    {
                        CastFixedSpellOnObject(SPELL_LESSER_MIND_BLANK, oTarget, 5);
                        return TRUE;
                    }
                }
                if(((nSum & ~(nClarity | nSleep)) == 0) && (GetHasFixedSpell(SPELL_CLARITY) && !(bFoundPotionOnly && bNotIsSelf)))
                {
                    CastFixedSpellOnObject(SPELL_CLARITY, oTarget, 2);
                    return TRUE;
                }
                if((nSum & (nFear | nSlow | nClarity | nParalsis | nCurse)) && (GetHasFixedSpell(SPELL_GREATER_RESTORATION) && !(bFoundPotionOnly && bNotIsSelf)))
                {
                    CastFixedSpellOnObject(SPELL_GREATER_RESTORATION, oTarget, 7);
                    return TRUE;
                }
                if((nSum & nDarkness) && (GetHasFixedSpell(SPELL_TRUE_SEEING) && !(bFoundPotionOnly && bNotIsSelf)))
                {
                    CastFixedSpellOnObject(SPELL_TRUE_SEEING, oTarget, 5);
                    return TRUE;
                }
                if((nSum & nDarkness) && (GetHasFixedSpell(SPELL_DARKVISION) && !(bFoundPotionOnly && bNotIsSelf)))
                {
                    CastFixedSpellOnObject(SPELL_DARKVISION, oTarget, 2);
                    return TRUE;
                }
                if((nSum & (nBlindDeaf | nParalsis | nDrained)))
                {
                    if (GetHasFixedSpell(SPELL_RESTORATION) && !(bFoundPotionOnly && bNotIsSelf))
                    {
                        CastFixedSpellOnObject(SPELL_RESTORATION, oTarget, 4);
                        return TRUE;
                    }
                    if (GetHasFixedSpell(SPELL_HENCH_Restoration_Others) && !(bFoundPotionOnly && bNotIsSelf))
                    {
                        CastFixedSpellOnObject(SPELL_HENCH_Restoration_Others, oTarget, 4);
                        return TRUE;
                    }                    
                    if (GetHasFixedSpell(SPELL_GREATER_RESTORATION) && !(bFoundPotionOnly && bNotIsSelf))
                    {
                        CastFixedSpellOnObject(SPELL_GREATER_RESTORATION, oTarget, 7);
                        return TRUE;
                    }
                }
                if (nDispelSum)
                {                    
                    if (GetHasFixedSpell(SPELL_GREATER_DISPELLING) && !(bFoundPotionOnly && bNotIsSelf))
                    {
                        CastFixedSpellOnObject(SPELL_GREATER_DISPELLING, oTarget, 6);
                        return TRUE;
                    }
                    if (GetHasFixedSpell(SPELL_DISPEL_MAGIC) && !(bFoundPotionOnly && bNotIsSelf))
                    {
                        CastFixedSpellOnObject(SPELL_DISPEL_MAGIC, oTarget, 3);
                        return TRUE;
                    }
                    if (GetHasFixedSpell(SPELL_LESSER_DISPEL) && !(bFoundPotionOnly && bNotIsSelf))
                    {
                        CastFixedSpellOnObject(SPELL_LESSER_DISPEL, oTarget, 2);
                        return TRUE;
                    }
                }
                // after this point try to get rid of anything doing worst first
                if(nSum & (nClarity | nSleep | nSlow))
                {
                    if (GetHasFixedSpell(SPELL_MIND_BLANK) && !(bFoundPotionOnly && bNotIsSelf))
                    {
                        CastFixedSpellOnObject(SPELL_MIND_BLANK, oTarget, 8);
                        return TRUE;
                    }
                    if (GetHasFixedSpell(SPELL_LESSER_MIND_BLANK) && !(bFoundPotionOnly && bNotIsSelf))
                    {
                        CastFixedSpellOnObject(SPELL_LESSER_MIND_BLANK, oTarget, 5);
                        return TRUE;
                    }
                }
                if((nSum & (nClarity | nSleep)) && GetHasFixedSpell(SPELL_CLARITY) && !(bFoundPotionOnly && bNotIsSelf))
                {
                    CastFixedSpellOnObject(SPELL_CLARITY, oTarget, 2);
                    return TRUE;
                }
                if((nSum & (nParalsis | nFreedom | nSlow)) && GetHasFixedSpell(SPELL_FREEDOM_OF_MOVEMENT) && !(bFoundPotionOnly && bNotIsSelf))
                {
                    CastFixedSpellOnObject(SPELL_FREEDOM_OF_MOVEMENT, oTarget, 4);
                    return TRUE;
                }
                if((nSum & nParalsis) && GetHasFixedSpell(SPELL_REMOVE_PARALYSIS) && !(bFoundPotionOnly && bNotIsSelf))
                {
                    CastFixedSpellOnObject(SPELL_REMOVE_PARALYSIS, oTarget, 2);
                    return TRUE;
                }
                if((nSum & nBlindDeaf) && GetHasFixedSpell(SPELL_REMOVE_BLINDNESS_AND_DEAFNESS) && !(bFoundPotionOnly && bNotIsSelf))
                {
                    CastFixedSpellOnObject(SPELL_REMOVE_BLINDNESS_AND_DEAFNESS, oTarget, 3);
                    return TRUE;
                }
                if((nSum & nCurse) && GetHasFixedSpell(SPELL_REMOVE_CURSE) && !(bFoundPotionOnly && bNotIsSelf))
                {
                    CastFixedSpellOnObject(SPELL_REMOVE_CURSE, oTarget, 3);
                    return TRUE;
                }
                if((nSum & nAbilityDrain) && GetHasFixedSpell(SPELL_LESSER_RESTORATION) && !(bFoundPotionOnly && bNotIsSelf))
                {
                    CastFixedSpellOnObject(SPELL_LESSER_RESTORATION, oTarget, 2);
                    return TRUE;
                }
                if((nSum & nPoison) && GetHasFixedSpell(SPELL_NEUTRALIZE_POISON) && !(bFoundPotionOnly && bNotIsSelf))
                {
                    CastFixedSpellOnObject(SPELL_NEUTRALIZE_POISON, oTarget, 3);
                    return TRUE;
                }
                if((nSum & nDisease) && GetHasFixedSpell(SPELL_REMOVE_DISEASE) && !(bFoundPotionOnly && bNotIsSelf))
                {
                    CastFixedSpellOnObject(SPELL_REMOVE_DISEASE, oTarget, 3);
                    return TRUE;
                }
                if((nSum & nDisease) && GetHasFixedSpell(SPELL_NEUTRALIZE_POISON) && !(bFoundPotionOnly && bNotIsSelf))
                {
                    CastFixedSpellOnObject(SPELL_NEUTRALIZE_POISON, oTarget, 3);
                    return TRUE;
                }
                if((nSum & (nPoison | nDisease | nAbilityDrain)) && GetHasFixedSpell(SPELL_GREATER_RESTORATION) && !(bFoundPotionOnly && bNotIsSelf))
                {
                    CastFixedSpellOnObject(SPELL_GREATER_RESTORATION, oTarget, 7);
                    return TRUE;
                }
                if((nSum & nAbilityDrain) && GetHasFixedSpell(SPELL_RESTORATION) && !(bFoundPotionOnly && bNotIsSelf))
                {
                    CastFixedSpellOnObject(SPELL_RESTORATION, oTarget, 4);
                    return TRUE;
                }
                if((nSum & nAbilityDrain) && GetHasFixedSpell(SPELL_HENCH_Restoration_Others) && !(bFoundPotionOnly && bNotIsSelf))
                {
                    CastFixedSpellOnObject(SPELL_HENCH_Restoration_Others, oTarget, 4);
                    return TRUE;
                }
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lSelf);
        }
    }
    return FALSE;
}


// CURE DISEASE, POISON ETC
int HenchTalentCureCondition()
{
    return TalentCureConditionAllAllies(TRUE);
}

