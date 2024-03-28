/*

    Henchman Inventory And Battle AI

    This file contains routines used for using items (potions,
    scrolls, and rods by henchman and monsters. Uses talents along
    with silence to actually get the item spells into arrays for
    later use by GetHasFixedSpell. These talent spells are then cast
    by CastFixedSpellOnObject and CastFixedSpellAtLocation.
    
    Also deals with creatures with a negative effect on them that
    impacts spellcasting (silence, primary ability drain)

*/

#include "hench_i0_generic"

// void main() {    }

int bGlobalNoInventoryChange;

int potionsFound;
int potionCount;
const int maxPotionCount = 5;
talent potionTalent1, potionTalent2, potionTalent3, potionTalent4, potionTalent5;
int potionSpellID1, potionSpellID2, potionSpellID3, potionSpellID4, potionSpellID5;

int HasPotionTalentSpell(int spellID)
{
    if (potionCount < 1)
    {
        return FALSE;
    }
    if (spellID == potionSpellID1)
    {
        return TRUE;
    }
    if (potionCount < 2)
    {
        return FALSE;
    }
    if (spellID == potionSpellID2)
    {
        return TRUE;
    }
    if (potionCount < 3)
    {
        return FALSE;
    }
    if (spellID == potionSpellID3)
    {
        return TRUE;
    }
    if (potionCount < 4)
    {
        return FALSE;
    }
    if (spellID == potionSpellID4)
    {
        return TRUE;
    }
    if (potionCount < 5)
    {
        return FALSE;
    }
    if (spellID == potionSpellID5)
    {
        return TRUE;
    }
    return FALSE;
}


talent GetPotionTalentSpell(int spellID)
{
    if (potionCount < 1)
    {
        return potionTalent1;
    }
    if (spellID == potionSpellID1)
    {
        return potionTalent1;
    }
    if (spellID == potionSpellID2)
    {
        return potionTalent2;
    }
    if (spellID == potionSpellID3)
    {
        return potionTalent3;
    }
    if (spellID == potionSpellID4)
    {
        return potionTalent4;
    }
    if (spellID == potionSpellID5)
    {
        return potionTalent5;
    }
    return potionTalent1;
}


void AddPotionTalentSpell(talent talentSpellFound)
{
    if (potionCount >= maxPotionCount)
    {
        return;
    }
    potionCount += 1;
    int spellID = GetIdFromTalent(talentSpellFound);
    if (potionCount == 1)
    {
        potionTalent1 = talentSpellFound;
        potionSpellID1 = spellID;
        return;
    }
    if (potionCount == 2)
    {
        potionTalent2 = talentSpellFound;
        potionSpellID2 = spellID;
        return;
    }
    if (potionCount == 3)
    {
        potionTalent3 = talentSpellFound;
        potionSpellID3 = spellID;
        return;
    }
    if (potionCount == 4)
    {
        potionTalent4 = talentSpellFound;
        potionSpellID4 = spellID;
        return;
    }
    if (potionCount == 5)
    {
        potionTalent5 = talentSpellFound;
        potionSpellID5 = spellID;
        return;
    }
}


int FindPotionTalentsByCategory(int nCategory, int maximumToAdd)
{
    int nTry, dupsFound, spellsFound;

    if (maximumToAdd > maxPotionCount)
    {
        maximumToAdd = maxPotionCount;
    }
    talent tBest = GetCreatureTalentBest(nCategory, 20);
    talent tLast = TalentSkill(SKILL_HEAL);
    while (nTry < 10 && potionCount < maximumToAdd && GetIsTalentValid(tBest))
    {
        if (tBest == tLast)
        {
            dupsFound++;
        }
        else
        {
            dupsFound = 0;
        }
        if (dupsFound > 2)
        {
            break;
        }
        int nType = GetTypeFromTalent(tBest);
        if (nType == TALENT_TYPE_SPELL)
        {
            int nNewSpellID = GetIdFromTalent(tBest);
            if (!HasPotionTalentSpell(nNewSpellID))
            {
                AddPotionTalentSpell(tBest);
                spellsFound ++;
                potionsFound = TRUE;
                dupsFound = 0;
            }
        }
        nTry ++;
        if (spellsFound > 2)
        {
            break;
        }
        tLast = tBest;
        tBest = GetCreatureTalentRandom(nCategory);
    }
    return spellsFound;
}


void InitializePotionTalents()
{
    if (GetLocalInt(OBJECT_SELF, henchNoPotionStr))
    {
        return;
    }
    FindPotionTalentsByCategory(TALENT_CATEGORY_BENEFICIAL_PROTECTION_POTION, maxPotionCount);
    if (potionCount == maxPotionCount)
    {
        return;
    }
    FindPotionTalentsByCategory(TALENT_CATEGORY_BENEFICIAL_CONDITIONAL_POTION, maxPotionCount);
    if (potionCount == maxPotionCount)
    {
        return;
    }
    FindPotionTalentsByCategory(TALENT_CATEGORY_BENEFICIAL_ENHANCEMENT_POTION, maxPotionCount);
    if (potionCount == maxPotionCount)
    {
        return;
    }
    if (bGlobalNoInventoryChange && potionCount == 0)
    {
        SetLocalInt(OBJECT_SELF, henchNoPotionStr, TRUE);
    }
}


int itemSpellsFound;
int onlyUseTalents;
int itemTalentSpellCount;
int itemTalentBoundary;
const int maxItemTalentSpellCount = 15;
talent itemTalent1, itemTalent2, itemTalent3, itemTalent4, itemTalent5,
        itemTalent6, itemTalent7, itemTalent8, itemTalent9, itemTalent10,
        itemTalent11, itemTalent12, itemTalent13, itemTalent14, itemTalent15;
int itemSpellID1, itemSpellID2, itemSpellID3, itemSpellID4, itemSpellID5,
        itemSpellID6, itemSpellID7, itemSpellID8, itemSpellID9, itemSpellID10,
        itemSpellID11, itemSpellID12, itemSpellID13, itemSpellID14, itemSpellID15;

int HasItemTalentSpell(int spellID)
{
    if (itemTalentSpellCount < 1)
    {
        return FALSE;
    }
    if (spellID == itemSpellID1)
    {
        return 1;
    }
    if (itemTalentSpellCount < 2)
    {
        return FALSE;
    }
    if (spellID == itemSpellID2)
    {
        return 2;
    }
    if (itemTalentSpellCount < 3)
    {
        return FALSE;
    }
    if (spellID == itemSpellID3)
    {
        return 3;
    }
    if (itemTalentSpellCount < 4)
    {
        return FALSE;
    }
    if (spellID == itemSpellID4)
    {
        return 4;
    }
    if (itemTalentSpellCount < 5)
    {
        return FALSE;
    }
    if (spellID == itemSpellID5)
    {
        return 5;
    }
    if (itemTalentSpellCount < 6)
    {
        return FALSE;
    }
    if (spellID == itemSpellID6)
    {
        return 6;
    }
    if (itemTalentSpellCount < 7)
    {
        return FALSE;
    }
    if (spellID == itemSpellID7)
    {
        return 7;
    }
    if (itemTalentSpellCount < 8)
    {
        return FALSE;
    }
    if (spellID == itemSpellID8)
    {
        return 8;
    }
    if (itemTalentSpellCount < 9)
    {
        return FALSE;
    }
    if (spellID == itemSpellID9)
    {
        return 9;
    }
    if (itemTalentSpellCount < 10)
    {
        return FALSE;
    }
    if (spellID == itemSpellID10)
    {
        return 10;
    }
    if (itemTalentSpellCount < 11)
    {
        return FALSE;
    }
    if (spellID == itemSpellID11)
    {
        return 11;
    }
    if (itemTalentSpellCount < 12)
    {
        return FALSE;
    }
    if (spellID == itemSpellID12)
    {
        return 12;
    }
    if (itemTalentSpellCount < 13)
    {
        return FALSE;
    }
    if (spellID == itemSpellID13)
    {
        return 13;
    }
    if (itemTalentSpellCount < 14)
    {
        return FALSE;
    }
    if (spellID == itemSpellID14)
    {
        return 14;
    }
    if (itemTalentSpellCount < 15)
    {
        return FALSE;
    }
    if (spellID == itemSpellID15)
    {
        return 15;
    }
    return FALSE;
}


talent GetItemTalentSpell(int spellID)
{
    if (itemTalentSpellCount < 1)
    {
        return itemTalent1;
    }
    if (spellID == itemSpellID1)
    {
        return itemTalent1;
    }
    if (spellID == itemSpellID2)
    {
        return itemTalent2;
    }
    if (spellID == itemSpellID3)
    {
        return itemTalent3;
    }
    if (spellID == itemSpellID4)
    {
        return itemTalent4;
    }
    if (spellID == itemSpellID5)
    {
        return itemTalent5;
    }
    if (spellID == itemSpellID6)
    {
        return itemTalent6;
    }
    if (spellID == itemSpellID7)
    {
        return itemTalent7;
    }
    if (spellID == itemSpellID8)
    {
        return itemTalent8;
    }
    if (spellID == itemSpellID9)
    {
        return itemTalent9;
    }
    if (spellID == itemSpellID10)
    {
        return itemTalent10;
    }
    if (spellID == itemSpellID11)
    {
        return itemTalent11;
    }
    if (spellID == itemSpellID12)
    {
        return itemTalent12;
    }
    if (spellID == itemSpellID13)
    {
        return itemTalent13;
    }
    if (spellID == itemSpellID14)
    {
        return itemTalent14;
    }
    if (spellID == itemSpellID15)
    {
        return itemTalent15;
    }
    return itemTalent1;
}


void AddItemTalentSpell(talent talentSpellFound)
{
    if (itemTalentSpellCount >= maxItemTalentSpellCount)
    {
        return;
    }
    itemTalentSpellCount += 1;
    int spellID = GetIdFromTalent(talentSpellFound);

    if (itemTalentSpellCount == 1)
    {
        itemTalent1 = talentSpellFound;
        itemSpellID1 = spellID;
        return;
    }
    if (itemTalentSpellCount == 2)
    {
        itemTalent2 = talentSpellFound;
        itemSpellID2 = spellID;
        return;
    }
    if (itemTalentSpellCount == 3)
    {
        itemTalent3 = talentSpellFound;
        itemSpellID3 = spellID;
        return;
    }
    if (itemTalentSpellCount == 4)
    {
        itemTalent4 = talentSpellFound;
        itemSpellID4 = spellID;
        return;
    }
    if (itemTalentSpellCount == 5)
    {
        itemTalent5 = talentSpellFound;
        itemSpellID5 = spellID;
        return;
    }
    if (itemTalentSpellCount == 6)
    {
        itemTalent6 = talentSpellFound;
        itemSpellID6 = spellID;
        return;
    }
    if (itemTalentSpellCount == 7)
    {
        itemTalent7 = talentSpellFound;
        itemSpellID7 = spellID;
        return;
    }
    if (itemTalentSpellCount == 8)
    {
        itemTalent8 = talentSpellFound;
        itemSpellID8 = spellID;
        return;
    }
    if (itemTalentSpellCount == 9)
    {
        itemTalent9 = talentSpellFound;
        itemSpellID9 = spellID;
        return;
    }
    if (itemTalentSpellCount == 10)
    {
        itemTalent10 = talentSpellFound;
        itemSpellID10 = spellID;
        return;
    }
    if (itemTalentSpellCount == 11)
    {
        itemTalent11 = talentSpellFound;
        itemSpellID11 = spellID;
        return;
    }
    if (itemTalentSpellCount == 12)
    {
        itemTalent12 = talentSpellFound;
        itemSpellID12 = spellID;
        return;
    }
    if (itemTalentSpellCount == 13)
    {
        itemTalent13 = talentSpellFound;
        itemSpellID13 = spellID;
        return;
    }
    if (itemTalentSpellCount == 14)
    {
        itemTalent14 = talentSpellFound;
        itemSpellID14 = spellID;
        return;
    }
    if (itemTalentSpellCount == 15)
    {
        itemTalent15 = talentSpellFound;
        itemSpellID15 = spellID;
        return;
    }
}


int FindItemSpellTalentsByCategory(int nCategory, int maximumToAdd)
{
    int nTry, dupsFound, spellsFound;

    if (maximumToAdd > maxItemTalentSpellCount)
    {
        maximumToAdd = maxItemTalentSpellCount;
    }
    talent tBest = GetCreatureTalentBest(nCategory, 20);
    talent tLast = TalentSkill(SKILL_HEAL);
    while (nTry < 10 && itemTalentSpellCount < maximumToAdd && GetIsTalentValid(tBest))
    {
        if (tBest == tLast)
        {
            dupsFound++;
        }
        else
        {
            dupsFound = 0;
        }
        if (dupsFound > 2)
        {
            break;
        }
        int nType = GetTypeFromTalent(tBest);
        if (nType == TALENT_TYPE_SPELL)
        {
            int nNewSpellID = GetIdFromTalent(tBest);            
            
            if (!HasItemTalentSpell(nNewSpellID))
            {
                AddItemTalentSpell(tBest);
                spellsFound ++;
                itemSpellsFound = TRUE;
                dupsFound = 0;
            }
        }
        nTry ++;
        if (spellsFound > 4)
        {
            break;
        }
        tLast = tBest;
        tBest = GetCreatureTalentRandom(nCategory);
    }
    return spellsFound;
}


void InitializeHealingSpellTalents(int iCheckIfNone = TRUE)
{
    int maximumToAdd = itemTalentSpellCount + 1;
    FindItemSpellTalentsByCategory(TALENT_CATEGORY_BENEFICIAL_HEALING_TOUCH, maximumToAdd);
    if (itemTalentSpellCount == maximumToAdd)
    {
        return;
    }
    maximumToAdd = itemTalentSpellCount + 1;
    FindItemSpellTalentsByCategory(TALENT_CATEGORY_BENEFICIAL_HEALING_AREAEFFECT, maximumToAdd);
    if (itemTalentSpellCount == maximumToAdd)
    {
        return;
    }
}


void InitializeAttackSpellTalents(int iCheckIfNone = TRUE)
{
    if (iCheckIfNone && GetLocalInt(OBJECT_SELF, henchNoAttackSpStr))
    {
        return;
    }
    int maximumToAdd = itemTalentSpellCount + 10;
    int origItemTalentSpellCount = itemTalentSpellCount;
    if (maximumToAdd > maxItemTalentSpellCount)
    {
        maximumToAdd = maxItemTalentSpellCount;
    }
    FindItemSpellTalentsByCategory(TALENT_CATEGORY_HARMFUL_AREAEFFECT_DISCRIMINANT, maximumToAdd);
    if (itemTalentSpellCount == maximumToAdd)
    {
        return;
    }
    FindItemSpellTalentsByCategory(TALENT_CATEGORY_HARMFUL_AREAEFFECT_INDISCRIMINANT, maximumToAdd);
    if (itemTalentSpellCount == maximumToAdd)
    {
        return;
    }
    FindItemSpellTalentsByCategory(TALENT_CATEGORY_HARMFUL_RANGED, maximumToAdd);
    if (itemTalentSpellCount == maximumToAdd)
    {
        return;
    }
    FindItemSpellTalentsByCategory(TALENT_CATEGORY_HARMFUL_TOUCH, maximumToAdd);
    if (itemTalentSpellCount == maximumToAdd)
    {
        return;
    }
    FindItemSpellTalentsByCategory(TALENT_CATEGORY_HARMFUL_MELEE, maximumToAdd);
    if (itemTalentSpellCount == maximumToAdd)
    {
        return;
    }
    maximumToAdd = itemTalentSpellCount + 1;
    FindItemSpellTalentsByCategory(TALENT_CATEGORY_BENEFICIAL_OBTAIN_ALLIES, maximumToAdd);
    if (iCheckIfNone && bGlobalNoInventoryChange && origItemTalentSpellCount == itemTalentSpellCount)
    {
        SetLocalInt(OBJECT_SELF, henchNoAttackSpStr, TRUE);
    }
}


void InitializeEnhanceSpellTalents(int iCheckIfNone = TRUE)
{
    if (iCheckIfNone && GetLocalInt(OBJECT_SELF, henchNoEnhanceSpStr))
    {
        return;
    }
    int maximumToAdd = itemTalentSpellCount + 10;
    int origItemTalentSpellCount = itemTalentSpellCount;
    if (maximumToAdd > maxItemTalentSpellCount)
    {
        maximumToAdd = maxItemTalentSpellCount;
    }
    FindItemSpellTalentsByCategory(TALENT_CATEGORY_BENEFICIAL_PROTECTION_AREAEFFECT, maximumToAdd);
    if (itemTalentSpellCount == maximumToAdd)
    {
        return;
    }
    FindItemSpellTalentsByCategory(TALENT_CATEGORY_BENEFICIAL_PROTECTION_SELF, maximumToAdd);
    if (itemTalentSpellCount == maximumToAdd)
    {
        return;
    }
    FindItemSpellTalentsByCategory(TALENT_CATEGORY_BENEFICIAL_PROTECTION_SINGLE, maximumToAdd);
    if (itemTalentSpellCount == maximumToAdd)
    {
        return;
    }
    FindItemSpellTalentsByCategory(TALENT_CATEGORY_BENEFICIAL_ENHANCEMENT_AREAEFFECT, maximumToAdd);
    if (itemTalentSpellCount == maximumToAdd)
    {
        return;
    }
    FindItemSpellTalentsByCategory(TALENT_CATEGORY_BENEFICIAL_ENHANCEMENT_SELF, maximumToAdd);
    if (itemTalentSpellCount == maximumToAdd)
    {
        return;
    }
    FindItemSpellTalentsByCategory(TALENT_CATEGORY_BENEFICIAL_ENHANCEMENT_SINGLE, maximumToAdd);
    if (iCheckIfNone && bGlobalNoInventoryChange && itemTalentSpellCount == origItemTalentSpellCount)
    {
        SetLocalInt(OBJECT_SELF, henchNoEnhanceSpStr, TRUE);
    }
}


void InitializeConditionalSpellTalents(int iCheckIfNone = TRUE)
{
    if (iCheckIfNone && GetLocalInt(OBJECT_SELF, henchNoCondSpStr))
    {
        return;
    }
    int maximumToAdd = itemTalentSpellCount + 5;
    int origItemTalentSpellCount = itemTalentSpellCount;
    if (maximumToAdd > maxItemTalentSpellCount)
    {
        maximumToAdd = maxItemTalentSpellCount;
    }
    FindItemSpellTalentsByCategory(TALENT_CATEGORY_BENEFICIAL_CONDITIONAL_AREAEFFECT, maximumToAdd);
    if (itemTalentSpellCount == maximumToAdd)
    {
        return;
    }
    FindItemSpellTalentsByCategory(TALENT_CATEGORY_BENEFICIAL_CONDITIONAL_SINGLE, maximumToAdd);
    if (itemTalentSpellCount == maximumToAdd)
    {
        return;
    }
    // 0 talent category is misc spells (***** category in spells.2da)
    FindItemSpellTalentsByCategory(0, maximumToAdd);
    if (iCheckIfNone && bGlobalNoInventoryChange && itemTalentSpellCount == origItemTalentSpellCount)
    {
        SetLocalInt(OBJECT_SELF, henchNoCondSpStr, TRUE);
    }
}


// caster level (spell resistance)
int nMySpellCasterLevel;
int nMySpellCasterSpellPenetrationBonus;
int nMySpellCasterSpellPenetration;
// DC for spells
int nMySpellAbilityLevel1;
int nMySpellAbilityLevel12;
int nMySpellAbilityLevel14;
int nMySpellCasterDC;
int nMySpellCasterDCAdjust;

int nGlobalMeleeAttackers;
int bAnySpellcastingClasses;


int InitializeClassByPosition(int iPosition)
{
    int iAbility, iAbilityMod;
    int nClass = GetClassByPosition(iPosition);
    int nClassLevel = GetLevelByPosition(iPosition);
    
    switch (nClass)
    {
        case CLASS_TYPE_INVALID:
            return FALSE;            
        case CLASS_TYPE_FIGHTER:
        case CLASS_TYPE_ROGUE:
        case CLASS_TYPE_MONK:
        case CLASS_TYPE_DIVINECHAMPION:
        case CLASS_TYPE_WEAPON_MASTER:
        case CLASS_TYPE_PALEMASTER:
        case CLASS_TYPE_SHIFTER:
        case CLASS_TYPE_DWARVENDEFENDER:
        case CLASS_TYPE_DRAGONDISCIPLE:
            break;            
        case CLASS_TYPE_PALADIN:
        case CLASS_TYPE_RANGER:
            if (nClassLevel < 4)
            {
                break;
            }
        case CLASS_TYPE_CLERIC:
        case CLASS_TYPE_DRUID:
            if (nMySpellCasterLevel < nClassLevel)
            {
                nMySpellCasterLevel = nClassLevel; 
            }
            iAbilityMod = GetAbilityModifier(ABILITY_WISDOM);
            if (nMySpellCasterDC < iAbilityMod)
            {
                nMySpellCasterDC = iAbilityMod; 
            }
            bAnySpellcastingClasses = TRUE;
            break;
        case CLASS_TYPE_WIZARD:
            if (nMySpellCasterLevel < nClassLevel)
            {
                nMySpellCasterLevel = nClassLevel; 
            }
            iAbilityMod = GetAbilityModifier(ABILITY_INTELLIGENCE);
            if (nMySpellCasterDC < iAbilityMod)
            {
                nMySpellCasterDC = iAbilityMod; 
            }
            bAnySpellcastingClasses = TRUE;
            break;        
        case CLASS_TYPE_BARD:
        case CLASS_TYPE_SORCERER:
            if (nMySpellCasterLevel < nClassLevel)
            {
                nMySpellCasterLevel = nClassLevel; 
            }
            iAbilityMod = GetAbilityModifier(ABILITY_CHARISMA);
            if (nMySpellCasterDC < iAbilityMod)
            {
                nMySpellCasterDC = iAbilityMod; 
            }
            bAnySpellcastingClasses = TRUE;
            break;
        default:
            if (GetCasterLevel(OBJECT_SELF) > 0)
            {                
                nMySpellCasterLevel = GetCasterLevel(OBJECT_SELF); 
            }        
            else if (nMySpellCasterLevel < GetHitDice(OBJECT_SELF))
            {
                nMySpellCasterLevel = GetHitDice(OBJECT_SELF);
                if (nMySpellCasterLevel > 15)
                {
                    // special abilities now limited to 15
                    nMySpellCasterLevel = 15;   
                }
            }
            iAbilityMod = GetAbilityModifier(ABILITY_CHARISMA);
            if (nMySpellCasterDC < iAbilityMod)
            {
                nMySpellCasterDC = iAbilityMod; 
            }
    }
    
    switch (nClass)
    {
        case CLASS_TYPE_PALADIN:
        case CLASS_TYPE_RANGER:
        // note: paladin and ranger spells don't work unless talents are used
            // (spells start at level 4)
            return nClassLevel > 3;
    }
    return FALSE;
}


int InitializeSpellCasting()
{
    int bResult1 = InitializeClassByPosition(1);
    int bResult2 = InitializeClassByPosition(2);
    int bResult3 = InitializeClassByPosition(3);
    
    if (GetAbilityScore(OBJECT_SELF, ABILITY_INTELLIGENCE) < 9)
    {
        nMySpellCasterDC = 1000;
        nMySpellAbilityLevel1 = 1000;
        nMySpellAbilityLevel12 = 1000;
        nMySpellAbilityLevel14 = 1000;
        nMySpellCasterSpellPenetration = 1000;
        nMySpellCasterDCAdjust = -1000;
    }
    else
    {
        // note this is one above for 1 to 20 roll for save
        nMySpellCasterDCAdjust = 1 - d4(2);
        nMySpellCasterDC += 10 + nMySpellCasterDCAdjust; 
        nMySpellAbilityLevel1 = 10 + nMySpellCasterDCAdjust;
        nMySpellAbilityLevel12 = nMySpellAbilityLevel1;
        nMySpellAbilityLevel14 = nMySpellAbilityLevel1;
        nMySpellAbilityLevel1 += GetHitDice(OBJECT_SELF);
        nMySpellAbilityLevel12 += GetHitDice(OBJECT_SELF)/2;
        nMySpellAbilityLevel14 += GetHitDice(OBJECT_SELF)/4;
        
        if (GetHasFeat(FEAT_EPIC_SPELL_PENETRATION))
        {
            nMySpellCasterSpellPenetrationBonus = 6;
        }
        else if (GetHasFeat(FEAT_GREATER_SPELL_PENETRATION))
        {
            nMySpellCasterSpellPenetrationBonus = 4;
        }
        else if (GetHasFeat(FEAT_SPELL_PENETRATION))
        {
            nMySpellCasterSpellPenetrationBonus = 2;
        }
        
        nMySpellCasterSpellPenetration = nMySpellCasterLevel + nMySpellCasterSpellPenetrationBonus + d4(2) - 1;
    }
    
    return bResult1 || bResult2 || bResult3;
}


// note after calling this many Talent* calls will not work since the cutscene immobilize
// remains in effect.
void InitializeItemSpells(int bPolymorphed, int bNotBuffOnly = TRUE)
{
    itemSpellsFound = FALSE;
    onlyUseTalents = FALSE;
    itemTalentSpellCount = 0;
    bGlobalNoInventoryChange = GetAssociateType(OBJECT_SELF) != ASSOCIATE_TYPE_HENCHMAN;
    
    nGlobalMeleeAttackers = GetNumberOfMeleeAttackers();
    
    int bSpellCastingProblem = InitializeSpellCasting();

    if (bPolymorphed)
    {
        // polymorphed creatues can only use potions
        onlyUseTalents = TRUE;
        if (GetIsObjectValid(GetFirstItemInInventory()))
        {
            InitializePotionTalents();
        }
        return;        
    }
        
    if (bSpellCastingProblem || GetHasAnyEffect2(EFFECT_TYPE_SILENCE, EFFECT_TYPE_SPELL_FAILURE))
    {
        if (bNotBuffOnly)
        {
            InitializeHealingSpellTalents(FALSE);
        }
        InitializeConditionalSpellTalents(FALSE);
        if (bNotBuffOnly)
        {
            InitializeAttackSpellTalents(FALSE);
        }
        InitializeEnhanceSpellTalents(FALSE);
        onlyUseTalents = TRUE;
    }

    itemTalentBoundary = itemTalentSpellCount;
    if (GetIsObjectValid(GetFirstItemInInventory()) && GetCreatureUseItems(OBJECT_SELF))
    {
        int bCutSceneImmobile = GetHasEffect(EFFECT_TYPE_CUTSCENEIMMOBILIZE);    
    
        InitializePotionTalents();

        if (!bCutSceneImmobile)
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectCutsceneImmobilize(), OBJECT_SELF, 10.0);
        }
        if (bNotBuffOnly)
        {
            InitializeHealingSpellTalents();
        }
        InitializeConditionalSpellTalents();
        if (bNotBuffOnly)
        {
            InitializeAttackSpellTalents();
        }
        InitializeEnhanceSpellTalents();
        
        if (!bCutSceneImmobile)
        {
            effect eCurrent = GetFirstEffect(OBJECT_SELF);
            while(GetIsEffectValid(eCurrent))
            {
                if(GetEffectType(eCurrent) == EFFECT_TYPE_CUTSCENEIMMOBILIZE)
                {
                   RemoveEffect(OBJECT_SELF, eCurrent);
                }
                eCurrent = GetNextEffect(OBJECT_SELF);
            }
        }
    }    
}


int bFoundPotionOnly;
int bFoundItemSpell;
int bFoundSpellGlobal;

int GetHasFixedSpell(int spellID)
{
    if (!onlyUseTalents && GetHasSpell(spellID))
    {
        bFoundSpellGlobal = TRUE;
        bFoundItemSpell = FALSE;
        bFoundPotionOnly = FALSE;
        return TRUE;
    }
    if (HasItemTalentSpell(spellID))
    {
        bFoundSpellGlobal = TRUE;
        bFoundPotionOnly = FALSE;
        // best guess if have spell, then no item
        bFoundItemSpell = !GetHasSpell(spellID); 
        return TRUE;
    }
    if (HasPotionTalentSpell(spellID))
    {
        bFoundSpellGlobal = TRUE;
        bFoundItemSpell = TRUE;
        bFoundPotionOnly = TRUE;
        return TRUE;
    }
    return FALSE;
}


void CheckCastingMode(int nSpellLevel, int nSpell)
{
    int bCurrentDefCastMode = GetActionMode(OBJECT_SELF, ACTION_MODE_DEFENSIVE_CAST);
    int bNewDefCastMode;

    if (!nGlobalMeleeAttackers || GetHasFeat(FEAT_EPIC_IMPROVED_COMBAT_CASTING) ||
    // shadow spells don't work with defensive casting
        (nSpell >= SPELL_SHADES_SUMMON_SHADOW && nSpell <= SPELL_GREATER_SHADOW_CONJURATION_MINOR_GLOBE))
    {
        bNewDefCastMode = FALSE;            
    }
    else
    {
        int nConcentration = GetSkillRank(SKILL_CONCENTRATION);
        if (nConcentration > 13 + nSpellLevel)
        {
            bNewDefCastMode = TRUE;            
        }
    }
    if (bCurrentDefCastMode != bNewDefCastMode)
    {
        ActionDoCommand(SetActionMode(OBJECT_SELF, ACTION_MODE_DEFENSIVE_CAST, bNewDefCastMode));
    }
}


void ActionCastFixedSpellOnObject(int nSpell, object oTarget)
{
    int bUseCheat = FALSE;
    int nMainSpell;
    // first test if cleric possibly doing spontaneous casting
    if (GetLevelByClass(CLASS_TYPE_CLERIC) > 0)
    {
        switch(nSpell)
        {
        case SPELL_CURE_MINOR_WOUNDS:        
        case SPELL_INFLICT_MINOR_WOUNDS:
        case SPELL_CURE_LIGHT_WOUNDS:
        case SPELL_INFLICT_LIGHT_WOUNDS:
        case SPELL_CURE_MODERATE_WOUNDS:
        case SPELL_INFLICT_MODERATE_WOUNDS:
        case SPELL_CURE_SERIOUS_WOUNDS:
        case SPELL_INFLICT_SERIOUS_WOUNDS:
        case SPELL_CURE_CRITICAL_WOUNDS:
        case SPELL_INFLICT_CRITICAL_WOUNDS:
            bUseCheat = TRUE;
            nMainSpell = nSpell;
        }
    }
    switch(nSpell)
    {
    case SPELL_HOLY_AURA:        
    case SPELL_UNHOLY_AURA:    
        bUseCheat = TRUE;
        nMainSpell = 323;
        break;
    case SPELL_MAGIC_CIRCLE_AGAINST_EVIL:
    case SPELL_MAGIC_CIRCLE_AGAINST_GOOD:
        bUseCheat = TRUE;
        nMainSpell = 322;
        break;
    case SPELL_PROTECTION_FROM_EVIL:
    case SPELL_PROTECTION_FROM_GOOD:
        bUseCheat = TRUE;
        nMainSpell = 321;
        break;
    case SPELL_SHADES_SUMMON_SHADOW:
    case SPELL_SHADES_CONE_OF_COLD:
    case SPELL_SHADES_FIREBALL:
    case SPELL_SHADES_STONESKIN:
    case SPELL_SHADES_WALL_OF_FIRE:
        bUseCheat = TRUE;
        nMainSpell = 158;
        break;
    case SPELL_SHADOW_CONJURATION_SUMMON_SHADOW:
    case SPELL_SHADOW_CONJURATION_DARKNESS:
    case SPELL_SHADOW_CONJURATION_INIVSIBILITY:
    case SPELL_SHADOW_CONJURATION_MAGE_ARMOR:
    case SPELL_SHADOW_CONJURATION_MAGIC_MISSILE:
        bUseCheat = TRUE;
        nMainSpell = 159;
        break;
    case SPELL_GREATER_SHADOW_CONJURATION_SUMMON_SHADOW:
    case SPELL_GREATER_SHADOW_CONJURATION_ACID_ARROW:
    case SPELL_GREATER_SHADOW_CONJURATION_MIRROR_IMAGE:
    case SPELL_GREATER_SHADOW_CONJURATION_WEB:
    case SPELL_GREATER_SHADOW_CONJURATION_MINOR_GLOBE:
        bUseCheat = TRUE;
        nMainSpell = 71;
        break;
    case SPELL_SHAPECHANGE:    
        switch (d8())
        {
        case 1:
        case 2:
            nSpell = 392;
            break;
        case 3:
            nSpell = 393;
            break;
        case 4:
        case 5:
            nSpell = 394;
            break;
        case 6:
            nSpell = 395;
            break;
        default:
            nSpell = 396;
        }
        bUseCheat = TRUE;
        nMainSpell = SPELL_SHAPECHANGE;
        break;
    case SPELL_POLYMORPH_SELF:
        switch (d8())
        {
        case 1:
            nSpell = 387;
            break;
        case 2:
        case 3:
        case 4:
            nSpell = 388;
            break;
        case 5:
        case 6:
            nSpell = 389;
            break;
        case 7:
            nSpell = 390;
            break;
        default:
            nSpell = 391;
        }
        bUseCheat = TRUE;
        nMainSpell = SPELL_POLYMORPH_SELF;
        break;
    }
    if (bUseCheat)
    {
        ActionCastSpellAtObject(nSpell, oTarget, METAMAGIC_ANY, TRUE);
        ActionDoCommand(DecrementRemainingSpellUses(OBJECT_SELF, nMainSpell));
    }
    else
    {
        ActionCastSpellAtObject(nSpell, oTarget);
    }    
}


void CastFixedSpellOnObject(int nSpell, object oTarget, int nSpellLevel)
{
    int bHasSpell = GetHasSpell(nSpell);
    int bEnableDefensivecasting = bAnySpellcastingClasses && bHasSpell;
    if (bEnableDefensivecasting)
    {
        // probably casting check if use of defensive casting
        CheckCastingMode(nSpellLevel, nSpell);
    }
    if (!nGlobalMeleeAttackers && !onlyUseTalents && bHasSpell)
    {
        ActionCastFixedSpellOnObject(nSpell, oTarget);
        return;
    }
    if (oTarget == OBJECT_SELF && HasPotionTalentSpell(nSpell))
    {
        ActionUseTalentOnObject(GetPotionTalentSpell(nSpell), OBJECT_SELF);
        return;
    }
    int itemPosition = HasItemTalentSpell(nSpell);
    if (itemPosition)
    {
        if (itemPosition <= itemTalentBoundary)
        {
            // probably casting check if use of defensive casting
            CheckCastingMode(nSpellLevel, nSpell);
        }
        ActionUseTalentOnObject(GetItemTalentSpell(nSpell), oTarget);
        return;
    }
    ActionCastFixedSpellOnObject(nSpell, oTarget);
}


void ActionCastFixedSpellAtLocation(int nSpell, location loc)
{
    int bUseCheat = FALSE;
    int nMainSpell;

    switch(nSpell)
    {
    case SPELL_SHADES_SUMMON_SHADOW:
    case SPELL_SHADES_CONE_OF_COLD:
    case SPELL_SHADES_FIREBALL:
    case SPELL_SHADES_WALL_OF_FIRE:
        bUseCheat = TRUE;
        nMainSpell = 158;
        break;
    case SPELL_SHADOW_CONJURATION_SUMMON_SHADOW:
    case SPELL_SHADOW_CONJURATION_DARKNESS:
        bUseCheat = TRUE;
        nMainSpell = 159;
        break;
    case SPELL_GREATER_SHADOW_CONJURATION_SUMMON_SHADOW:
    case SPELL_GREATER_SHADOW_CONJURATION_WEB:
        bUseCheat = TRUE;
        nMainSpell = 71;
        break;
    }
    if (bUseCheat)
    {
        ActionCastSpellAtLocation(nSpell, loc, METAMAGIC_ANY, TRUE);
        ActionDoCommand(DecrementRemainingSpellUses(OBJECT_SELF, nMainSpell));
    }
    else
    {
        ActionCastSpellAtLocation(nSpell, loc);
    }    
}


void CastFixedSpellAtLocation(int nSpell, location loc, int nSpellLevel)
{
    int bHasSpell = GetHasSpell(nSpell);
    int bEnableDefensivecasting = bAnySpellcastingClasses && bHasSpell;
    if (bEnableDefensivecasting)
    {
        // probably casting check if use of defensive casting
        CheckCastingMode(nSpellLevel, nSpell);
    }
    if (!nGlobalMeleeAttackers && !onlyUseTalents && bHasSpell)
    {
        ActionCastFixedSpellAtLocation(nSpell, loc);
        return;
    }
    int itemPosition = HasItemTalentSpell(nSpell);
    if (itemPosition)
    {
        if (itemPosition <= itemTalentBoundary)
        {
            // probably casting check if use of defensive casting
            CheckCastingMode(nSpellLevel, nSpell);
        }
        ActionUseTalentAtLocation(GetItemTalentSpell(nSpell), loc);
        return;
    }
    ActionCastFixedSpellAtLocation(nSpell, loc);
}
