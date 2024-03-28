// the henchman casts their spell

#include "hench_i0_spells"
#include "hench_i0_ai"


int GetBestBuffTarget2(int nSpell, int nItemProp)
{
    InitializeBuffTargets();
        
    int curCount;
    object oFriend;
        
    for (curCount = 0; curCount < nNumAlliesFound; curCount++)
    {        
        oFriend = GetObjectArray(OBJECT_SELF, henchAllyArrayStr, curCount);        
        if (!GetHasSpellEffect(nSpell, oFriend))
        {
            if (nItemProp < 0 || !GetCreatureHasItemProperty(nItemProp, oFriend))
            {
                // found target
                oBestBuffTarget = oFriend;                        
                return TRUE;
            }
        }
    }    
    return FALSE;
}


int GetBestAttribBuff2(int buffSelf, int buffOthers, int nLastSpellCast, int bForceSelf = FALSE)
{
    // determine available spells
    int nOwlsWisdom;
    if (GetHasFixedSpell(SPELL_OWLS_WISDOM) && nLastSpellCast != SPELL_OWLS_WISDOM)
    {
        nOwlsWisdom = bFoundPotionOnly ? 1 : 2;
    }    
    int nFoxsCunning;
    if (GetHasFixedSpell(SPELL_FOXS_CUNNING) && nLastSpellCast != SPELL_FOXS_CUNNING)
    {        
        nFoxsCunning = bFoundPotionOnly ? 1 : 2;  
    }    
    int nEagleSplendor;
    if (GetHasFixedSpell(SPELL_EAGLE_SPLEDOR) && nLastSpellCast != SPELL_EAGLE_SPLEDOR)
    {        
        nEagleSplendor = bFoundPotionOnly ? 1 : 2;  
    }
    // trim possible actions based on available spells
    if (!nOwlsWisdom && !nFoxsCunning && !nEagleSplendor)
    {
        return FALSE;
    }
    if (!buffOthers && !buffSelf)
    {
        return FALSE;
    }
    int bSelfOnly = (nOwlsWisdom < 2) && (nFoxsCunning < 2) && (nEagleSplendor < 2);    
    if (bSelfOnly && buffOthers && !buffSelf)
    {
        return FALSE;
    }
    if (bSelfOnly)
    {
        buffOthers = FALSE;
    }
    // prepare for loop counters
    InitializeBuffTargets();
    int curCount = buffSelf ? -1 : 0;
    int nMaxCount = buffOthers ? nNumAlliesFound : 0;
    object oHenchBuffTarget = OBJECT_SELF;
    int nThreshHold = 1;
    int nClass;
    for (; curCount < nMaxCount; curCount++)
    {
        if (curCount >= 0)
        {
            oHenchBuffTarget = GetObjectArray(OBJECT_SELF, henchAllyArrayStr, curCount);
            nThreshHold = 2;
        }
        
        if (nOwlsWisdom >= nThreshHold &&
            !GetHasSpellEffect(SPELL_OWLS_WISDOM, oHenchBuffTarget) &&
            (GetLevelByClass(CLASS_TYPE_CLERIC, oHenchBuffTarget) ||
            GetLevelByClass(CLASS_TYPE_DRUID, oHenchBuffTarget)))
        {
            CastSetLastSpellOnObject(SPELL_OWLS_WISDOM, oHenchBuffTarget, 2);
            return TRUE;
        }
        
        if (nFoxsCunning >= nThreshHold &&
            !GetHasSpellEffect(SPELL_FOXS_CUNNING, oHenchBuffTarget) &&
            GetLevelByClass(CLASS_TYPE_WIZARD))
        {
            CastSetLastSpellOnObject(SPELL_FOXS_CUNNING, oHenchBuffTarget, 2);
            return TRUE;
        }
        
        if (nEagleSplendor >= nThreshHold && 
            !GetHasSpellEffect(SPELL_EAGLE_SPLEDOR, oHenchBuffTarget) &&
            (GetLevelByClass(CLASS_TYPE_SORCERER, oHenchBuffTarget) ||
            GetLevelByClass(CLASS_TYPE_BARD, oHenchBuffTarget) ||
            GetLevelByClass(CLASS_TYPE_PALADIN, oHenchBuffTarget)))
        {
            CastSetLastSpellOnObject(SPELL_EAGLE_SPLEDOR, oHenchBuffTarget, 2);
            return TRUE;
        }
    }    
    return FALSE;
}


int HenchLongTermBuff(int buffSelf, int buffOthers, int bShortBuffEnabled)
{
    int nLastSpellCast = -1;    
    int iInvisStatus = buffSelf ? 100 : 0;    
    int iTargetGEAlign = ALIGNMENT_EVIL;    
    int nAreaPosition = 1000;
    int groupBuff = TRUE;
    
    if (GetBestAttribBuff2(buffSelf, buffOthers, -1))
    {
        return TRUE;
    }    
    
    while (1)
    {
//$LONGBUFFSTART
        if (GetHasFixedSpell(SPELL_PREMONITION))
        {
            if (nLastSpellCast != SPELL_PREMONITION)
            {
                if (buffSelf && !GetHasEffect(EFFECT_TYPE_DAMAGE_REDUCTION, OBJECT_SELF))
                {
                    CastSetLastSpellOnObject(SPELL_PREMONITION, OBJECT_SELF, 8); return TK_BUFFSELF;
                }
            }
        }
        if (GetHasFixedSpell(SPELL_SHADOW_SHIELD))
        {
            if (nLastSpellCast != SPELL_SHADOW_SHIELD && (d100() > 50))
            {
                if (buffSelf && !GetHasEffect(EFFECT_TYPE_DAMAGE_REDUCTION, OBJECT_SELF))
                {
                    CastSetLastSpellOnObject(SPELL_SHADOW_SHIELD, OBJECT_SELF, 7); return TK_BUFFSELF;
                }
            }
        }
        if (GetHasFixedSpell(SPELL_PROTECTION_FROM_SPELLS))
        {
            if (nLastSpellCast != SPELL_PROTECTION_FROM_SPELLS)
            {
                if (groupBuff && !GetHasSpellEffect(SPELL_PROTECTION_FROM_SPELLS, OBJECT_SELF))
                {
                    CastSetLastSpellOnObject(SPELL_PROTECTION_FROM_SPELLS, OBJECT_SELF, 7); return TK_BUFFSELF;
                }
            }
        }
        if (GetHasFixedSpell(SPELL_GREATER_STONESKIN))
        {
            if (nLastSpellCast != SPELL_GREATER_STONESKIN)
            {
                if (buffSelf && !GetHasEffect(EFFECT_TYPE_DAMAGE_REDUCTION, OBJECT_SELF))
                {
                    CastSetLastSpellOnObject(SPELL_GREATER_STONESKIN, OBJECT_SELF, 6); return TK_BUFFSELF;
                }
            }
        }
        if (GetHasFixedSpell(SPELL_ENERGY_BUFFER))
        {
            if (nLastSpellCast != SPELL_ENERGY_BUFFER)
            {
                if (buffSelf && !GetHasSpellEffect(SPELL_ELEMENTAL_SHIELD, OBJECT_SELF) && !GetHasSpellEffect(SPELL_PROTECTION_FROM_ELEMENTS, OBJECT_SELF) && !GetHasSpellEffect(SPELL_RESIST_ELEMENTS, OBJECT_SELF) && !GetHasSpellEffect(SPELL_ENDURE_ELEMENTS, OBJECT_SELF) && !GetHasSpellEffect(SPELL_ENERGY_BUFFER, OBJECT_SELF))
                {
                    CastSetLastSpellOnObject(SPELL_ENERGY_BUFFER, OBJECT_SELF, 5); return TK_BUFFSELF;
                }
            }
        }
        if (GetHasFixedSpell(SPELL_STONESKIN))
        {
            if (nLastSpellCast != SPELL_STONESKIN)
            {
                if (buffSelf && !GetHasEffect(EFFECT_TYPE_DAMAGE_REDUCTION, OBJECT_SELF))
                {
                    CastSetLastSpellOnObject(SPELL_STONESKIN, OBJECT_SELF, 4); return TK_BUFFSELF;
                }
                if (!bFoundPotionOnly && buffOthers  && GetBestBuffTarget(-1, EFFECT_TYPE_DAMAGE_REDUCTION, -1, -1))
                {
                    CastSetLastSpellOnObject(SPELL_STONESKIN, oBestBuffTarget, 4); return TK_BUFFOTHER;
                }
            }
        }
        if (GetHasFixedSpell(SPELL_GHOSTLY_VISAGE))
        {
            if (nLastSpellCast != SPELL_GHOSTLY_VISAGE)
            {
                if (buffSelf && !GetHasFixedSpell(SPELL_ETHEREAL_VISAGE) && !GetHasSpellEffect(SPELL_GHOSTLY_VISAGE, OBJECT_SELF))
                {
                    CastSetLastSpellOnObject(SPELL_GHOSTLY_VISAGE, OBJECT_SELF, 2); return TK_BUFFSELF;
                }
            }
        }
        if (GetHasFixedSpell(SPELL_SHIELD))
        {
            if (nLastSpellCast != SPELL_SHIELD)
            {
                if (buffSelf && !GetHasEffect(EFFECT_TYPE_AC_INCREASE, OBJECT_SELF))
                {
                    CastSetLastSpellOnObject(SPELL_SHIELD, OBJECT_SELF, 1); return TK_BUFFSELF;
                }
            }
        }
        if (GetHasFixedSpell(SPELL_TRUE_SEEING))
        {
            if (nLastSpellCast != SPELL_TRUE_SEEING)
            {
                if ( iInvisStatus && !GetHasSpellEffect(SPELL_TRUE_SEEING, OBJECT_SELF))
                {
                    CastSetLastSpellOnObject(SPELL_TRUE_SEEING, OBJECT_SELF, 6); return TK_BUFFSELF;
                }
            }
        }
        if (GetHasFixedSpell(SPELL_SPELL_RESISTANCE))
        {
            if (nLastSpellCast != SPELL_SPELL_RESISTANCE)
            {
                if (buffSelf && !GetHasSpellEffect(SPELL_SPELL_RESISTANCE, OBJECT_SELF) && !GetCreatureHasItemProperty(ITEM_PROPERTY_SPELL_RESISTANCE, OBJECT_SELF))
                {
                    CastSetLastSpellOnObject(SPELL_SPELL_RESISTANCE, OBJECT_SELF, 5); return TK_BUFFSELF;
                }
                if (!bFoundPotionOnly && buffOthers  && GetBestSpellProtTarget())
                {
                    CastSetLastSpellOnObject(SPELL_SPELL_RESISTANCE, oBestBuffTarget, 5); return TK_BUFFOTHER;
                }
            }
        }
        if (GetHasFixedSpell(SPELL_FREEDOM_OF_MOVEMENT))
        {
            if (nLastSpellCast != SPELL_FREEDOM_OF_MOVEMENT)
            {
                if (buffSelf && !GetHasSpellEffect(SPELL_FREEDOM_OF_MOVEMENT, OBJECT_SELF) && !GetCreatureHasItemProperty(ITEM_PROPERTY_FREEDOM_OF_MOVEMENT, OBJECT_SELF))
                {
                    CastSetLastSpellOnObject(SPELL_FREEDOM_OF_MOVEMENT, OBJECT_SELF, 4); return TK_BUFFSELF;
                }
                if (!bFoundPotionOnly && buffOthers  && GetBestBuffTarget2(SPELL_FREEDOM_OF_MOVEMENT,ITEM_PROPERTY_FREEDOM_OF_MOVEMENT))
                {
                    CastSetLastSpellOnObject(SPELL_FREEDOM_OF_MOVEMENT, oBestBuffTarget, 4); return TK_BUFFOTHER;
                }
            }
        }
        if (GetHasFixedSpell(SPELL_DEATH_WARD))
        {
            if (nLastSpellCast != SPELL_DEATH_WARD)
            {
                if (buffSelf && !GetIsImmune(OBJECT_SELF, IMMUNITY_TYPE_DEATH, OBJECT_SELF))
                {
                    CastSetLastSpellOnObject(SPELL_DEATH_WARD, OBJECT_SELF, 4); return TK_BUFFSELF;
                }
                if (!bFoundPotionOnly && buffOthers  && GetBestBuffTarget(IMMUNITY_TYPE_DEATH, -1, -1, -1))
                {
                    CastSetLastSpellOnObject(SPELL_DEATH_WARD, oBestBuffTarget, 4); return TK_BUFFOTHER;
                }
            }
        }
        if (GetHasFixedSpell(SPELL_PROTECTION_FROM_ELEMENTS))
        {
            if (nLastSpellCast != SPELL_PROTECTION_FROM_ELEMENTS)
            {
                if (buffSelf && !GetHasSpellEffect(SPELL_ENERGY_BUFFER, OBJECT_SELF) && !GetHasSpellEffect(SPELL_RESIST_ELEMENTS, OBJECT_SELF) && !GetHasSpellEffect(SPELL_ENDURE_ELEMENTS, OBJECT_SELF) && !GetHasSpellEffect(SPELL_ELEMENTAL_SHIELD, OBJECT_SELF) && !GetHasSpellEffect(SPELL_PROTECTION_FROM_ELEMENTS, OBJECT_SELF))
                {
                    CastSetLastSpellOnObject(SPELL_PROTECTION_FROM_ELEMENTS, OBJECT_SELF, 3); return TK_BUFFSELF;
                }
                if (!bFoundPotionOnly && buffOthers  && GetBestElemProtTarget())
                {
                    CastSetLastSpellOnObject(SPELL_PROTECTION_FROM_ELEMENTS, oBestBuffTarget, 3); return TK_BUFFOTHER;
                }
            }
        }
        if (GetHasFixedSpell(SPELL_MAGIC_CIRCLE_AGAINST_EVIL))
        {
            if (nLastSpellCast != SPELL_MAGIC_CIRCLE_AGAINST_EVIL)
            {
                if (groupBuff && iTargetGEAlign == ALIGNMENT_EVIL && !GetHasSpellEffect(SPELL_HOLY_AURA, OBJECT_SELF) && !GetHasSpellEffect(SPELL_PROTECTION_FROM_EVIL, OBJECT_SELF) && !GetHasSpellEffect(SPELL_MAGIC_CIRCLE_AGAINST_EVIL, OBJECT_SELF))
                {
                    CastSetLastSpellOnObject(SPELL_MAGIC_CIRCLE_AGAINST_EVIL, OBJECT_SELF, 3); return TK_BUFFSELF;
                }
            }
        }
        if (GetHasFixedSpell(SPELL_INVISIBILITY_PURGE))
        {
            if (nLastSpellCast != SPELL_INVISIBILITY_PURGE)
            {
                if ( iInvisStatus > 1 && !GetHasSpellEffect(SPELL_INVISIBILITY_PURGE, OBJECT_SELF))
                {
                    CastSetLastSpellOnObject(SPELL_INVISIBILITY_PURGE, OBJECT_SELF, 6); return TK_BUFFSELF;
                }
            }
        }
        if (GetHasFixedSpell(SPELL_RESIST_ELEMENTS))
        {
            if (nLastSpellCast != SPELL_RESIST_ELEMENTS)
            {
                if (buffSelf && !GetHasSpellEffect(SPELL_ENERGY_BUFFER, OBJECT_SELF) && !GetHasSpellEffect(SPELL_PROTECTION_FROM_ELEMENTS, OBJECT_SELF) && !GetHasSpellEffect(SPELL_ENDURE_ELEMENTS, OBJECT_SELF) && !GetHasSpellEffect(SPELL_ELEMENTAL_SHIELD, OBJECT_SELF) && !GetHasSpellEffect(SPELL_RESIST_ELEMENTS, OBJECT_SELF))
                {
                    CastSetLastSpellOnObject(SPELL_RESIST_ELEMENTS, OBJECT_SELF, 2); return TK_BUFFSELF;
                }
                if (!bFoundPotionOnly && buffOthers  && GetBestElemProtTarget())
                {
                    CastSetLastSpellOnObject(SPELL_RESIST_ELEMENTS, oBestBuffTarget, 2); return TK_BUFFOTHER;
                }
            }
        }
        {
            int attrResult = GetBestAttribBuff(buffSelf, buffOthers, nLastSpellCast);
            if (attrResult)
            {
                return attrResult;
            }
        }
        if (GetHasFixedSpell(SPELL_AID))
        {
            if (nLastSpellCast != SPELL_AID)
            {
                if (buffSelf && (!GetHasEffect(EFFECT_TYPE_ATTACK_INCREASE, OBJECT_SELF) || !GetHasEffect(EFFECT_TYPE_TEMPORARY_HITPOINTS, OBJECT_SELF)))
                {
                    CastSetLastSpellOnObject(SPELL_AID, OBJECT_SELF, 2); return TK_BUFFSELF;
                }
                if (!bFoundPotionOnly && buffOthers  && GetBestBuffTarget(-1, EFFECT_TYPE_ATTACK_INCREASE, EFFECT_TYPE_TEMPORARY_HITPOINTS, -1))
                {
                    CastSetLastSpellOnObject(SPELL_AID, oBestBuffTarget, 2); return TK_BUFFOTHER;
                }
            }
        }
        if (GetHasFixedSpell(SPELL_MAGE_ARMOR))
        {
            if (nLastSpellCast != SPELL_MAGE_ARMOR)
            {
                if (buffSelf && !GetHasSpellEffect(SPELL_MAGE_ARMOR, OBJECT_SELF))
                {
                    CastSetLastSpellOnObject(SPELL_MAGE_ARMOR, OBJECT_SELF, 1); return TK_BUFFSELF;
                }
                if (!bFoundPotionOnly && buffOthers  && GetBestBuffTarget2(SPELL_MAGE_ARMOR,-1))
                {
                    CastSetLastSpellOnObject(SPELL_MAGE_ARMOR, oBestBuffTarget, 1); return TK_BUFFOTHER;
                }
            }
        }
        if (GetHasFixedSpell(SPELL_SHIELD_OF_FAITH))
        {
            if (nLastSpellCast != SPELL_SHIELD_OF_FAITH)
            {
                if (buffSelf && !GetHasEffect(EFFECT_TYPE_AC_INCREASE, OBJECT_SELF))
                {
                    CastSetLastSpellOnObject(SPELL_SHIELD_OF_FAITH, OBJECT_SELF, 1); return TK_BUFFSELF;
                }
            }
        }
        if (nAreaPosition < 20)
        {
            break;
        }
        if (GetHasFixedSpell(SPELL_PROTECTION_FROM_EVIL))
        {
            if (nLastSpellCast != SPELL_PROTECTION_FROM_EVIL && iTargetGEAlign == ALIGNMENT_EVIL)
            {
                if (buffSelf && !GetHasSpellEffect(SPELL_HOLY_AURA, OBJECT_SELF) && !GetHasSpellEffect(SPELL_MAGIC_CIRCLE_AGAINST_EVIL, OBJECT_SELF) && !GetIsImmune(OBJECT_SELF, IMMUNITY_TYPE_MIND_SPELLS, OBJECT_SELF))
                {
                    CastSetLastSpellOnObject(SPELL_PROTECTION_FROM_EVIL, OBJECT_SELF, 1); return TK_BUFFSELF;
                }
                if (!bFoundPotionOnly && buffOthers  && GetBestBuffTarget(IMMUNITY_TYPE_MIND_SPELLS, EFFECT_TYPE_AC_INCREASE, EFFECT_TYPE_SAVING_THROW_INCREASE, -1))
                {
                    CastSetLastSpellOnObject(SPELL_PROTECTION_FROM_EVIL, oBestBuffTarget, 1); return TK_BUFFOTHER;
                }
            }
        }
        if (GetHasFixedSpell(SPELL_ENTROPIC_SHIELD))
        {
            if (nLastSpellCast != SPELL_ENTROPIC_SHIELD)
            {
                if (buffSelf && !GetHasEffect(EFFECT_TYPE_CONCEALMENT, OBJECT_SELF))
                {
                    CastSetLastSpellOnObject(SPELL_ENTROPIC_SHIELD, OBJECT_SELF, 1); return TK_BUFFSELF;
                }
            }
        }
        if (GetHasFixedSpell(SPELL_ENDURE_ELEMENTS))
        {
            if (nLastSpellCast != SPELL_ENDURE_ELEMENTS)
            {
                if (buffSelf && !GetHasSpellEffect(SPELL_ENERGY_BUFFER, OBJECT_SELF) && !GetHasSpellEffect(SPELL_PROTECTION_FROM_ELEMENTS, OBJECT_SELF) && !GetHasSpellEffect(SPELL_RESIST_ELEMENTS, OBJECT_SELF) && !GetHasSpellEffect(SPELL_ELEMENTAL_SHIELD, OBJECT_SELF) && !GetHasSpellEffect(SPELL_ENDURE_ELEMENTS, OBJECT_SELF))
                {
                    CastSetLastSpellOnObject(SPELL_ENDURE_ELEMENTS, OBJECT_SELF, 1); return TK_BUFFSELF;
                }
                if (!bFoundPotionOnly && buffOthers  && GetBestElemProtTarget())
                {
                    CastSetLastSpellOnObject(SPELL_ENDURE_ELEMENTS, oBestBuffTarget, 1); return TK_BUFFOTHER;
                }
            }
        }
        if (GetHasFixedSpell(SPELL_BLESS))
        {
            if (nLastSpellCast != SPELL_BLESS)
            {
                if (groupBuff && !GetHasFixedSpell(SPELL_PRAYER) && !GetHasSpellEffect(SPELL_BLESS, OBJECT_SELF))
                {
                    CastSetLastSpellOnObject(SPELL_BLESS, OBJECT_SELF, 1); return TK_BUFFSELF;
                }
            }
        }
        if (GetHasFixedSpell(SPELL_ETHEREALNESS))
        {
            if (nLastSpellCast != SPELL_ETHEREALNESS)
            {
                if (buffSelf && !GetHasSpellEffect(SPELL_ETHEREALNESS, OBJECT_SELF))
                {
                    CastSetLastSpellOnObject(SPELL_ETHEREALNESS, OBJECT_SELF, 7); return TK_BUFFSELF;
                }
            }
        }
//$LONGBUFFEND
        break;
    }
    
    return TK_NOSPELL;
}


int HenchLongBuffInvis(int buffSelf, int buffOthers)
{
    if (GetHasFixedSpell(SPELL_IMPROVED_INVISIBILITY))
    {
        if (buffSelf && !GetHasEffect(EFFECT_TYPE_INVISIBILITY, OBJECT_SELF))
        {
            CastSetLastSpellOnObject(SPELL_IMPROVED_INVISIBILITY, OBJECT_SELF, 4); return TK_BUFFSELF;
        }
        if (!bFoundPotionOnly && buffOthers  && GetBestBuffTarget(-1, EFFECT_TYPE_INVISIBILITY, -1, -1))
        {
            CastSetLastSpellOnObject(SPELL_IMPROVED_INVISIBILITY, oBestBuffTarget, 4); return TK_BUFFOTHER;
        }
    }
    if (GetHasFixedSpell(SPELL_INVISIBILITY_SPHERE))
    {
        if (!GetHasEffect(EFFECT_TYPE_INVISIBILITY, OBJECT_SELF))
        {
            CastSetLastSpellOnObject(SPELL_INVISIBILITY_SPHERE, OBJECT_SELF, 3); return TK_BUFFSELF;
        }
    }
    if (GetHasFixedSpell(SPELL_INVISIBILITY))
    {
        if (buffSelf && !GetHasEffect(EFFECT_TYPE_INVISIBILITY, OBJECT_SELF))
        {
            CastSetLastSpellOnObject(SPELL_INVISIBILITY, OBJECT_SELF, 2); return TK_BUFFSELF;
        }
        if (!bFoundPotionOnly && buffOthers  && GetBestBuffTarget(-1, EFFECT_TYPE_INVISIBILITY, -1, -1))
        {
            CastSetLastSpellOnObject(SPELL_INVISIBILITY, oBestBuffTarget, 4); return TK_BUFFOTHER;
        }
    }
    
    return TK_NOSPELL;
}


int HenchShortTermBuff(int buffSelf, int buffOthers)
{
//    object oAnimalCompanion = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION);    
//    int buffAnimalCompanion = buffSelf && GetIsObjectValid(oAnimalCompanion);

    int nLastSpellCast = -1;    
    int iInvisStatus = TRUE;    
    int iTargetGEAlign = ALIGNMENT_EVIL;    
    int nAreaPosition = 1000;
    int bUseMeleeAttackSpells = TRUE;
    int groupBuff = TRUE;
    
    while (1)
    {
//$SHORTBUFFSTART
        if (GetHasFixedSpell(SPELL_GREATER_SPELL_MANTLE))
        {
            if (nLastSpellCast != SPELL_GREATER_SPELL_MANTLE)
            {
                if (buffSelf && !GetHasEffect(EFFECT_TYPE_SPELLLEVELABSORPTION, OBJECT_SELF))
                {
                    CastSetLastSpellOnObject(SPELL_GREATER_SPELL_MANTLE, OBJECT_SELF, 9); return TK_BUFFSELF;
                }
            }
        }
        if (GetHasFixedSpell(SPELL_SPELL_MANTLE))
        {
            if (nLastSpellCast != SPELL_SPELL_MANTLE)
            {
                if (buffSelf  && !GetHasEffect(EFFECT_TYPE_SPELLLEVELABSORPTION, OBJECT_SELF))
                {
                    CastSetLastSpellOnObject(SPELL_SPELL_MANTLE, OBJECT_SELF, 7); return TK_BUFFSELF;
                }
            }
        }
        if (GetHasFixedSpell(SPELL_GLOBE_OF_INVULNERABILITY))
        {
            if (nLastSpellCast != SPELL_GLOBE_OF_INVULNERABILITY)
            {
                if (buffSelf && !GetHasEffect(EFFECT_TYPE_SPELLLEVELABSORPTION, OBJECT_SELF))
                {
                    CastSetLastSpellOnObject(SPELL_GLOBE_OF_INVULNERABILITY, OBJECT_SELF, 6); return TK_BUFFSELF;
                }
            }
        }
        if (GetHasFixedSpell(SPELL_ETHEREAL_VISAGE))
        {
            if (nLastSpellCast != SPELL_ETHEREAL_VISAGE)
            {
                if (buffSelf && !GetHasSpellEffect(SPELL_ETHEREAL_VISAGE, OBJECT_SELF))
                {
                    CastSetLastSpellOnObject(SPELL_ETHEREAL_VISAGE, OBJECT_SELF, 5); return TK_BUFFSELF;
                }
            }
        }
        if (GetHasFixedSpell(SPELL_REGENERATE))
        {
            if (nLastSpellCast != SPELL_REGENERATE)
            {
                if (buffSelf && !GetHasEffect(EFFECT_TYPE_REGENERATE, OBJECT_SELF) && !GetCreatureHasItemProperty(ITEM_PROPERTY_REGENERATION, OBJECT_SELF))
                {
                    CastSetLastSpellOnObject(SPELL_REGENERATE, OBJECT_SELF, 7); return TK_BUFFSELF;
                }
                if (!bFoundPotionOnly && buffOthers  && GetBestBuffTarget(-1, EFFECT_TYPE_REGENERATE, -1, ITEM_PROPERTY_REGENERATION))
                {
                    CastSetLastSpellOnObject(SPELL_REGENERATE, oBestBuffTarget, 7); return TK_BUFFOTHER;
                }
            }
        }
        if (GetHasFixedSpell(SPELL_MONSTROUS_REGENERATION))
        {
            if (nLastSpellCast != SPELL_MONSTROUS_REGENERATION)
            {
                if (buffSelf && !GetHasEffect(EFFECT_TYPE_REGENERATE, OBJECT_SELF) && !GetCreatureHasItemProperty(ITEM_PROPERTY_REGENERATION, OBJECT_SELF))
                {
                    CastSetLastSpellOnObject(SPELL_MONSTROUS_REGENERATION, OBJECT_SELF, 5); return TK_BUFFSELF;
                }
                if (!bFoundPotionOnly && buffOthers  && GetBestBuffTarget(-1, EFFECT_TYPE_REGENERATE, -1, ITEM_PROPERTY_REGENERATION))
                {
                    CastSetLastSpellOnObject(SPELL_MONSTROUS_REGENERATION, oBestBuffTarget, 5); return TK_BUFFOTHER;
                }
            }
        }
        if (GetHasFixedSpell(SPELL_MASS_HASTE))
        {
            if (nLastSpellCast != SPELL_MASS_HASTE)
            {
                if (groupBuff && !GetHasEffect(EFFECT_TYPE_HASTE, OBJECT_SELF) && !GetCreatureHasItemProperty(ITEM_PROPERTY_HASTE, OBJECT_SELF))
                {
                    CastSetLastSpellOnObject(SPELL_MASS_HASTE, OBJECT_SELF, 6); return TK_BUFFSELF;
                }
            }
        }
        if (GetHasFixedSpell(SPELL_LESSER_SPELL_MANTLE))
        {
            if (nLastSpellCast != SPELL_LESSER_SPELL_MANTLE)
            {
                if (buffSelf && !GetHasEffect(EFFECT_TYPE_SPELLLEVELABSORPTION, OBJECT_SELF))
                {
                    CastSetLastSpellOnObject(SPELL_LESSER_SPELL_MANTLE, OBJECT_SELF, 5); return TK_BUFFSELF;
                }
            }
        }
        if (GetHasFixedSpell(SPELL_MESTILS_ACID_SHEATH))
        {
            if (nLastSpellCast != SPELL_MESTILS_ACID_SHEATH)
            {
                if (buffSelf && !GetHasSpellEffect(SPELL_MESTILS_ACID_SHEATH, OBJECT_SELF))
                {
                    CastSetLastSpellOnObject(SPELL_MESTILS_ACID_SHEATH, OBJECT_SELF, 5); return TK_BUFFSELF;
                }
            }
        }
        if (GetHasFixedSpell(SPELL_MINOR_GLOBE_OF_INVULNERABILITY))
        {
            if (nLastSpellCast != SPELL_MINOR_GLOBE_OF_INVULNERABILITY)
            {
                if (buffSelf && !GetHasEffect(EFFECT_TYPE_SPELLLEVELABSORPTION, OBJECT_SELF))
                {
                    CastSetLastSpellOnObject(SPELL_MINOR_GLOBE_OF_INVULNERABILITY, OBJECT_SELF, 4); return TK_BUFFSELF;
                }
            }
        }
        if (GetHasFixedSpell(SPELL_ELEMENTAL_SHIELD))
        {
            if (nLastSpellCast != SPELL_ELEMENTAL_SHIELD)
            {
                if (buffSelf && !GetHasSpellEffect(SPELL_ENERGY_BUFFER, OBJECT_SELF) && !GetHasSpellEffect(SPELL_PROTECTION_FROM_ELEMENTS, OBJECT_SELF) && !GetHasSpellEffect(SPELL_RESIST_ELEMENTS, OBJECT_SELF) && !GetHasSpellEffect(SPELL_ENDURE_ELEMENTS, OBJECT_SELF) && !GetHasSpellEffect(SPELL_ELEMENTAL_SHIELD, OBJECT_SELF))
                {
                    CastSetLastSpellOnObject(SPELL_ELEMENTAL_SHIELD, OBJECT_SELF, 4); return TK_BUFFSELF;
                }
            }
        }
        if (GetHasFixedSpell(SPELL_DIVINE_POWER))
        {
            if (nLastSpellCast != SPELL_DIVINE_POWER)
            {
                if (buffSelf && bUseMeleeAttackSpells && !GetHasSpellEffect(SPELL_DIVINE_POWER, OBJECT_SELF))
                {
                    CastSetLastSpellOnObject(SPELL_DIVINE_POWER, OBJECT_SELF, 4); return TK_BUFFSELF;
                }
            }
        }
        if (GetHasFixedSpell(SPELL_HASTE))
        {
            if (nLastSpellCast != SPELL_HASTE)
            {
                if (buffSelf && !GetHasEffect(EFFECT_TYPE_HASTE, OBJECT_SELF) && !GetCreatureHasItemProperty(ITEM_PROPERTY_HASTE, OBJECT_SELF))
                {
                    CastSetLastSpellOnObject(SPELL_HASTE, OBJECT_SELF, 3); return TK_BUFFSELF;
                }
                if (!bFoundPotionOnly && buffOthers  && GetBestBuffTarget(-1, EFFECT_TYPE_HASTE, -1, ITEM_PROPERTY_HASTE))
                {
                    CastSetLastSpellOnObject(SPELL_HASTE, oBestBuffTarget, 3); return TK_BUFFOTHER;
                }
            }
        }
        if (GetHasFixedSpell(SPELL_PRAYER))
        {
            if (nLastSpellCast != SPELL_PRAYER)
            {
                if (groupBuff && !GetHasSpellEffect(SPELL_PRAYER, OBJECT_SELF))
                {
                    CastSetLastSpellOnObject(SPELL_PRAYER, OBJECT_SELF, 3); return TK_BUFFSELF;
                }
            }
        }
        if (GetHasFixedSpell(SPELL_DEATH_ARMOR))
        {
            if (nLastSpellCast != SPELL_DEATH_ARMOR)
            {
                if (buffSelf && !GetHasSpellEffect(SPELL_DEATH_ARMOR, OBJECT_SELF))
                {
                    CastSetLastSpellOnObject(SPELL_DEATH_ARMOR, OBJECT_SELF, 2); return TK_BUFFSELF;
                }
            }
        }
        if (GetHasFixedSpell(SPELL_CLARITY))
        {
            if (nLastSpellCast != SPELL_CLARITY)
            {
                if (buffSelf && !GetIsImmune(OBJECT_SELF, IMMUNITY_TYPE_MIND_SPELLS, OBJECT_SELF))
                {
                    CastSetLastSpellOnObject(SPELL_CLARITY, OBJECT_SELF, 3); return TK_BUFFSELF;
                }
                if (!bFoundPotionOnly && buffOthers  && GetBestBuffTarget(IMMUNITY_TYPE_MIND_SPELLS, -1, -1, -1))
                {
                    CastSetLastSpellOnObject(SPELL_CLARITY, oBestBuffTarget, 3); return TK_BUFFOTHER;
                }
            }
        }
        if (GetHasFixedSpell(SPELL_DIVINE_FAVOR))
        {
            if (nLastSpellCast != SPELL_DIVINE_FAVOR)
            {
                if (buffSelf && bUseMeleeAttackSpells && !GetHasEffect(EFFECT_TYPE_ATTACK_INCREASE, OBJECT_SELF))
                {
                    CastSetLastSpellOnObject(SPELL_DIVINE_FAVOR, OBJECT_SELF, 1); return TK_BUFFSELF;
                }
            }
        }
        if (GetHasFixedSpell(SPELL_RESISTANCE))
        {
            if (nLastSpellCast != SPELL_RESISTANCE)
            {
                if (buffSelf && !GetHasEffect(EFFECT_TYPE_SAVING_THROW_INCREASE, OBJECT_SELF))
                {
                    CastSetLastSpellOnObject(SPELL_RESISTANCE, OBJECT_SELF, 1); return TK_BUFFSELF;
                }
                if (!bFoundPotionOnly && buffOthers  && GetBestBuffTarget(-1, EFFECT_TYPE_SAVING_THROW_INCREASE, -1, -1))
                {
                    CastSetLastSpellOnObject(SPELL_RESISTANCE, oBestBuffTarget, 1); return TK_BUFFOTHER;
                }
            }
        }
        if (GetHasFixedSpell(SPELL_SANCTUARY))
        {
            if (nLastSpellCast != SPELL_SANCTUARY)
            {
                if (buffSelf && !GetHasEffect(EFFECT_TYPE_SANCTUARY, OBJECT_SELF))
                {
                    CastSetLastSpellOnObject(SPELL_SANCTUARY, OBJECT_SELF, 1); return TK_BUFFSELF;
                }
            }
        }
//$SHORTBUFFEND
        break;
    }
    
    return TK_NOSPELL;
}


void InitializeSingleBuffTarget(object oBuffTarget)
{
    if (bBuffTargetInitDone)
    {
        return;
    }
    bBuffTargetInitDone = TRUE;
    nNumAlliesFound = 1;
    SetObjectArray(OBJECT_SELF, henchAllyArrayStr, 0, oBuffTarget);
}


void main()
{    
//    Jug_Debug(GetName(OBJECT_SELF) + " in buff code action " + IntToString(GetCurrentAction()));    
    int nBuffType = GetLocalInt(OBJECT_SELF, "X2_BUFFING_TYPE");    
    int bShortBuffEnabled = nBuffType == 1 || nBuffType == 3;
    int bLongBuffEnabled = nBuffType == 2 || nBuffType == 3;
    bGlobalAttrBuffOver = TRUE;

    talent tSummon;
    if (bLongBuffEnabled && !GetIsObjectValid(GetAssociate(ASSOCIATE_TYPE_SUMMONED)) &&
        !GetLocalInt(OBJECT_SELF, "DontSummon"))
    {
        tSummon = GetCreatureTalentBest(TALENT_CATEGORY_BENEFICIAL_OBTAIN_ALLIES, 20);
    }

    InitializeItemSpells(GetHasEffect(EFFECT_TYPE_POLYMORPH), FALSE);
       
    object oBuffTarget = GetLocalObject(OBJECT_SELF, "Henchman_Spell_Target");
    
    // TODO custom initialization of allies
    int buffSelf = TRUE;
    int buffOthers = TRUE;
    int buffGroup = TRUE;
    
    if (!GetIsObjectValid(oBuffTarget))
    {
        InitializeBuffTargets();
    }
    else if (oBuffTarget != OBJECT_SELF)
    {
        InitializeSingleBuffTarget(oBuffTarget);
        buffSelf = FALSE;
    }
    else
    {
        buffOthers = FALSE;
    }
    
    int curBuffCount = GetLocalInt(OBJECT_SELF, henchBuffCountStr);    
    
//    Jug_Debug(GetName(OBJECT_SELF) + " buff type " + IntToString(nBuffType));
    
    if (bLongBuffEnabled && GetIsTalentValid(tSummon))
    {
        ActionUseTalentAtLocation(tSummon, GetLocation(OBJECT_SELF));
        SetLocalInt(OBJECT_SELF, henchBuffCountStr, curBuffCount + 1);   
        return;        
    }
    if (bLongBuffEnabled &&
        HenchLongTermBuff(buffSelf, buffOthers, bShortBuffEnabled))
    {        
        SetLocalInt(OBJECT_SELF, henchBuffCountStr, curBuffCount + 1);   
        return;        
    }
    if (bShortBuffEnabled &&
        HenchShortTermBuff(buffSelf, buffOthers))
    {
        SetLocalInt(OBJECT_SELF, henchBuffCountStr, curBuffCount + 1);           
        return;
    }
    // make allies invisible (done last since can't buff allies if they are invisible)
    if (bLongBuffEnabled &&
        HenchLongBuffInvis(buffSelf, buffOthers))
    {        
        SetLocalInt(OBJECT_SELF, henchBuffCountStr, curBuffCount + 1);   
        return;        
    }
    if (bShortBuffEnabled && HenchTalentBardSong())
    {
        SetLocalInt(OBJECT_SELF, henchBuffCountStr, curBuffCount + 1);   
        return;        
    }
        
    if (curBuffCount == 0)
    {
            // didn't find any buff spells
        PlayVoiceChat(VOICE_CHAT_CUSS);                
    }
    else
    {
        PlayVoiceChat(VOICE_CHAT_TASKCOMPLETE);    
    }
    
    SetLocalInt(OBJECT_SELF, henchBuffCountStr, 0);
    SetLocalInt(OBJECT_SELF, "Deekin_Spell_Cast", 0);
    SetLocalObject(OBJECT_SELF, "Henchman_Spell_Target", OBJECT_INVALID);
    SetLocalInt(OBJECT_SELF, "X2_BUFFING_TYPE", 0);
}

