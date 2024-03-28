/*

    Henchman Inventory And Battle AI

    This file contains routines used in equipping monsters
    and henchman. Contains modified EquipAppropriateWeapons
    function (renamed HenchEquipAppropriateWeapons)

*/

#include "hench_i0_generic"


const int HENCH_AI_WEAPON_INIT =          0x00000001;
const int HENCH_AI_HAS_MELEE =            0x00000002;
const int HENCH_AI_HAS_MELEE_WEAPON =     0x00000004;
const int HENCH_AI_HAS_RANGED_WEAPON =    0x00000008;


const string HENCH_AI_WEAPON = "HENCH_AI_WEAPON";


// void main() {    }


void SetWeaponState(int nCondition, int bValid = TRUE)
{
    int nStatus = GetLocalInt(OBJECT_SELF, HENCH_AI_WEAPON);
    if (bValid)
    {
        nStatus = nStatus | nCondition;
        SetLocalInt(OBJECT_SELF, HENCH_AI_WEAPON, nStatus);
    }
    else
    {
        nStatus = nStatus & ~nCondition;
        SetLocalInt(OBJECT_SELF, HENCH_AI_WEAPON, nStatus);
    }
}


void UnequipWeapons()
{
    object oRight = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND);
    if (GetIsObjectValid(oRight))
    {
        ActionUnequipItem(oRight);
    }
    object oLeft = GetItemInSlot(INVENTORY_SLOT_LEFTHAND);
    if (GetIsObjectValid(oLeft))
    {
        ActionUnequipItem(oLeft);
    }
}


void EquipShield(int bIndicateStatus)
{
    int iHaveShieldStatus = GetLocalInt(OBJECT_SELF, "HaveShieldStatus");
    object oShield = GetItemInSlot(INVENTORY_SLOT_LEFTHAND);
    if (iHaveShieldStatus == 2)
    {
        // not really a shield, get rid of
        if (GetIsObjectValid(oShield))
        {
            ActionUnequipItem(oShield);
        }
        return;
    }
    if (iHaveShieldStatus == 1)
    {
        object oStoredShield = GetLocalObject(OBJECT_SELF, "StoredShield");
        if (oStoredShield == oShield)
        {
            return;
        }

        if (GetIsObjectValid(oStoredShield) && (GetItemPossessor(oStoredShield) == OBJECT_SELF))
        {
            ActionEquipItem(oStoredShield, INVENTORY_SLOT_LEFTHAND);
            return;
        }
    }

    int nMaxValue = 0;
    int iCreatureSize = GetCreatureSize(OBJECT_SELF);
    object oRealMaster = GetRealMaster();
    int bNoPCMaster = !(GetIsObjectValid(oRealMaster) && GetIsPC(oRealMaster));
    if (GetIsObjectValid(oShield))
    {
        int nSize = 1;      // note start at one less so easy compare with creature size
        switch (GetBaseItemType(oShield))
        {
            case BASE_ITEM_TOWERSHIELD:
                nSize ++;
            case BASE_ITEM_LARGESHIELD:
                nSize ++;
            case BASE_ITEM_SMALLSHIELD:
                if (bNoPCMaster || GetIdentified(oShield))
                {
                    nMaxValue = GetGoldPieceValue(oShield);
                }
                else
                {
                    nMaxValue = 2;
                }
                break;
            case BASE_ITEM_TORCH:
                nMaxValue = 1;
                break;
            default:
                // not a shield - remove
                ActionUnequipItem(oShield);
                oShield = OBJECT_INVALID;
                break;
        }
    }
    object oItem = GetFirstItemInInventory(OBJECT_SELF);
    int iNewShield = FALSE;
    int tempValue;
    int bHasShieldProf = GetHasFeat(FEAT_SHIELD_PROFICIENCY);
    int bCantUseShield = FALSE;
    int bCanUseTorch = (iCreatureSize > 1) && GetCreatureUseItems(OBJECT_SELF);

    while (GetIsObjectValid(oItem))
    {
        int nSize = 1;      // note start at one less so easy compare with creature size
        switch (GetBaseItemType(oItem))
        {
            case BASE_ITEM_TOWERSHIELD:
                nSize ++;
            case BASE_ITEM_LARGESHIELD:
                nSize ++;
            case BASE_ITEM_SMALLSHIELD:
                if (bHasShieldProf && (iCreatureSize >= nSize))
                {
                    if (bNoPCMaster || GetIdentified(oItem))
                    {
                        tempValue = GetGoldPieceValue(oItem);
                    }
                    else
                    {
                        tempValue = 2;
                    }
                    if (tempValue > nMaxValue)
                    {
                        nMaxValue = tempValue;
                        oShield = oItem;
                        iNewShield = TRUE;
                    }
                }
                else
                {
                    bCantUseShield = TRUE;
                }
                break;
            case BASE_ITEM_TORCH:
                if (bCanUseTorch && (1 > nMaxValue))
                {
                    nMaxValue = 1;
                    oShield = oItem;
                    iNewShield = TRUE;
                }
                break;
            default:
                break;

        }
        oItem = GetNextItemInInventory(OBJECT_SELF);
    }
    if (nMaxValue > 0)
    {
        SetLocalInt(OBJECT_SELF, "HaveShieldStatus", 1);
        SetLocalObject(OBJECT_SELF, "StoredShield", oShield);
    }
    else
    {
        SetLocalInt(OBJECT_SELF, "HaveShieldStatus", 2);
        DeleteLocalObject(OBJECT_SELF, "StoredShield");
    }
    if (iNewShield)
    {
        ActionEquipItem(oShield, INVENTORY_SLOT_LEFTHAND);
    }
    else if (bCantUseShield && bIndicateStatus)
    {
        SpeakString(sHenchCantUseShield);
    }
}


//::///////////////////////////////////////////////
//:: Name GetWeaponSize
//:://////////////////////////////////////////////
/*
    Returns the Base Weopen size of oItem
*/
//:://////////////////////////////////////////////
//:: Created By: Yrean
//:: Modified By: Jasperre
//:://////////////////////////////////////////////

int GetMeleeWeaponSize(object oItem)
{
    int nBase = GetBaseItemType(oItem);
    if(nBase == BASE_ITEM_DAGGER || nBase == BASE_ITEM_KUKRI /*|| nBase == BASE_ITEM_SHURIKEN*/)
    {
        return 1;
    }
    if(nBase == BASE_ITEM_SHORTSWORD /*|| nBase == BASE_ITEM_LIGHTCROSSBOW*/ || nBase == BASE_ITEM_LIGHTMACE ||
        /*nBase == BASE_ITEM_SMALLSHIELD || nBase == BASE_ITEM_DART ||*/ nBase == BASE_ITEM_LIGHTHAMMER ||
        nBase == BASE_ITEM_HANDAXE || nBase == BASE_ITEM_KAMA || nBase == BASE_ITEM_SICKLE /*||
        nBase == BASE_ITEM_SLING || nBase == BASE_ITEM_THROWINGAXE*/)
    {
        return 2;
    }
    if(nBase == BASE_ITEM_LONGSWORD || nBase == BASE_ITEM_BATTLEAXE || nBase == BASE_ITEM_BASTARDSWORD ||
        nBase == BASE_ITEM_LIGHTFLAIL || nBase == BASE_ITEM_WARHAMMER || /*nBase == BASE_ITEM_HEAVYCROSSBOW ||*/
        /*nBase == BASE_ITEM_SHORTBOW || */ nBase == BASE_ITEM_CLUB || nBase == BASE_ITEM_KATANA ||
        nBase == BASE_ITEM_MORNINGSTAR || nBase == BASE_ITEM_RAPIER || nBase == BASE_ITEM_SCIMITAR /*||
        nBase == BASE_ITEM_LARGESHIELD*/ || nBase == BASE_ITEM_DWARVENWARAXE || nBase == BASE_ITEM_WHIP)
    {
        return 3;
    }
    // Large weapons
    if(/*nBase == BASE_ITEM_LONGBOW || */ nBase ==  BASE_ITEM_HALBERD || nBase == BASE_ITEM_TWOBLADEDSWORD ||
        nBase == BASE_ITEM_GREATSWORD || nBase == BASE_ITEM_GREATAXE || nBase == BASE_ITEM_DIREMACE ||
        nBase == BASE_ITEM_DOUBLEAXE || nBase == BASE_ITEM_HEAVYFLAIL || nBase == BASE_ITEM_QUARTERSTAFF ||
        nBase == BASE_ITEM_SCYTHE /*|| nBase == BASE_ITEM_TOWERSHIELD */ || nBase == BASE_ITEM_SHORTSPEAR ||
        nBase == BASE_ITEM_MAGICSTAFF)
    {
        return 4;
    }
    return 0;
}


int GetInitWeaponStatus()
{
    int nResult = GetLocalInt(OBJECT_SELF, HENCH_AI_WEAPON);
    if (nResult)
    {
        return nResult;
    }

    int bHasMeleeWeapon;
    int bHasMeleeAttack;
    int bHasRangedWeapon;

    object oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND);
    if (GetIsObjectValid(oItem))
    {
        if (GetWeaponRanged(oItem))
        {
            bHasRangedWeapon = TRUE;
        }
        else if (GetMeleeWeaponSize(oItem) > 0)
        {
            bHasMeleeWeapon = TRUE;
        }
    }
    oItem = GetFirstItemInInventory(OBJECT_SELF);
    while (GetIsObjectValid(oItem) && !(bHasMeleeWeapon && bHasRangedWeapon))
    {
        if (!bHasRangedWeapon && GetWeaponRanged(oItem))
        {
            bHasRangedWeapon = TRUE;
        }
        else if (!bHasMeleeWeapon && GetMeleeWeaponSize(oItem) > 0)
        {
            bHasMeleeWeapon = TRUE;
        }
        oItem = GetNextItemInInventory(OBJECT_SELF);
    }
    if (!bHasMeleeWeapon)
    {
        if (GetHasFeat(FEAT_IMPROVED_UNARMED_STRIKE))
        {
            bHasMeleeAttack = TRUE;
        }
        else if (GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_CWEAPON_R)))
        {
            bHasMeleeAttack = TRUE;
        }
        else if (GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_CWEAPON_B)))
        {
            bHasMeleeAttack = TRUE;
        }
        else if (GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_CWEAPON_L)))
        {
            bHasMeleeAttack = TRUE;
        }
    }
    else
    {
        bHasMeleeAttack = TRUE;
    }
    if (bHasMeleeAttack)
    {
        nResult = HENCH_AI_WEAPON_INIT | HENCH_AI_HAS_MELEE;
    }
    else
    {
        nResult = HENCH_AI_WEAPON_INIT;
    }
    if (bHasMeleeWeapon)
    {
        nResult = nResult | HENCH_AI_HAS_MELEE_WEAPON;
    }
    if (bHasRangedWeapon)
    {
        nResult = nResult | HENCH_AI_HAS_RANGED_WEAPON;
    }
    
    SetLocalInt(OBJECT_SELF, HENCH_AI_WEAPON, nResult);
    return nResult;
}


// Equip melee weapon(s) AND check for shield.
void EquipMeleeWeapons(object oTarget, int bIndicateStatus, int iCallNumber = 1)
{
    if (GetLocalInt(OBJECT_SELF, "UseRangedWeapons"))
    {
        return;
    }

    int nWeaponStatus = GetInitWeaponStatus();
    if (!(nWeaponStatus & HENCH_AI_HAS_MELEE_WEAPON))
    {
        if ((nWeaponStatus & HENCH_AI_HAS_MELEE))
        {
            // no weapons, has creature attacks, make sure ranged weapons removed            
            UnequipWeapons();                        
        }        
        return;
    }

    int dualWieldState = GetLocalInt(OBJECT_SELF, "DualWieldState");
    if (dualWieldState == 0)
    {
        dualWieldState = GetHasFeat(FEAT_TWO_WEAPON_FIGHTING) ? 1 : 2;
    }    
    object oRight = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND);
    if (GetWeaponRanged(oRight))
    {
        oRight = OBJECT_INVALID;               
    }
    
    if (dualWieldState == 2 || !GetIsObjectValid(oRight))
    {
        ActionEquipMostDamagingMelee(oTarget);
    }    
    
    if (iCallNumber > 1)
    {
        int iCurAction = GetCurrentAction();
        if (iCurAction != ACTION_ATTACKOBJECT && iCurAction != ACTION_MOVETOPOINT
            && iCurAction != ACTION_FOLLOW && iCurAction != ACTION_INVALID)
        {
            return;
        }
    }

    oRight = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND);
    int iCreatureSize = GetCreatureSize(OBJECT_SELF);
    int iRWeaponSize = GetMeleeWeaponSize(oRight);

    if (iRWeaponSize > iCreatureSize)
    {
        // two handed weapon - done
        return;
    }
    // for dual weapon selection, must wait until right weapon is equipped
    if (!GetIsObjectValid(oRight))
    {
        if (iCallNumber < 4)
        {
            DelayCommand(iCallNumber == 1 ? 0.1 : (iCallNumber == 2 ? 0.4 : 1.5 ),
                EquipMeleeWeapons(oTarget, bIndicateStatus, iCallNumber + 1));
        }
        else if (GetHasFeat(FEAT_IMPROVED_UNARMED_STRIKE))
        {
        }
        else if (GetIsObjectValid(oTarget))
        {
                // this problem can occur if the target has stoneskin, OBJECT_INVALID will
                // cause best weapon against generic target to be equipped
            EquipMeleeWeapons(OBJECT_INVALID, bIndicateStatus);
        }
        else
        {
            SetWeaponState(HENCH_AI_HAS_MELEE_WEAPON, FALSE);
        }
        return;
    }
    if (dualWieldState == 2)
    {
        EquipShield(bIndicateStatus);
        return;
    }
    // already have something in left
    object oOrigLeft = GetItemInSlot(INVENTORY_SLOT_LEFTHAND);
    int iHaveOffHandStatus = GetLocalInt(OBJECT_SELF, "HaveOffhandStatus");
    if (iHaveOffHandStatus == 2)
    {
        EquipShield(bIndicateStatus);
        return;
    }
    if (iHaveOffHandStatus == 1)
    {
        object oStoredOffHand = GetLocalObject(OBJECT_SELF, "StoredOffHand");
        if (oStoredOffHand == oOrigLeft)
        {
            return;
        }

        if (GetIsObjectValid(oStoredOffHand) && (GetItemPossessor(oStoredOffHand) == OBJECT_SELF) &&
            oRight != oStoredOffHand)
        {
            ActionEquipItem(oStoredOffHand, INVENTORY_SLOT_LEFTHAND);
            return;
        }
    }

    object oLeft = OBJECT_INVALID;
    int nLeftPrevEquip = GetIsObjectValid(oOrigLeft);
    int nMaxValue = 0;
    int iMaxWeaponSize = iCreatureSize;
    if (GetLocalInt(OBJECT_SELF, "LightOffHand") && (iRWeaponSize >= iCreatureSize))
    {
        iMaxWeaponSize--;
    }
    int iCurWeaponSize;
    if (nLeftPrevEquip)
    {
        iCurWeaponSize = GetMeleeWeaponSize(oOrigLeft);
        if (iCurWeaponSize != 0 && iCurWeaponSize <= iMaxWeaponSize)
        {
            if (GetIdentified(oOrigLeft))
            {
                nMaxValue = GetGoldPieceValue(oOrigLeft);
            }
            else
            {
                nMaxValue = 1;
            }
            oLeft = oOrigLeft;
        }
    }
    // Then look for more than 1 single handed melee weapon
    int iNewOffHand = FALSE;
    object oItem = GetFirstItemInInventory();
    while (GetIsObjectValid(oItem))
    {
        int nItemType = GetBaseItemType(oItem);
        if (nItemType != BASE_ITEM_LIGHTFLAIL && nItemType != BASE_ITEM_MORNINGSTAR &&
            nItemType != BASE_ITEM_WHIP)
        {
            iCurWeaponSize = GetMeleeWeaponSize(oItem);
            if (iCurWeaponSize != 0 && iCurWeaponSize <= iMaxWeaponSize)
            {
                int tempValue;
                if (GetIdentified(oItem))
                {
                    tempValue = GetGoldPieceValue(oItem);
                }
                else
                {
                    tempValue = 1;
                }
                if (tempValue > nMaxValue)
                {
                    nMaxValue = tempValue;
                    oLeft = oItem;
                    iNewOffHand = TRUE;
               }
            }
        }
        oItem = GetNextItemInInventory();
    }
    if (nMaxValue > 0)
    {
        SetLocalInt(OBJECT_SELF, "HaveOffhandStatus", 1);
        SetLocalObject(OBJECT_SELF, "StoredOffHand", oLeft);
    }
    else
    {
        SetLocalInt(OBJECT_SELF, "HaveOffhandStatus", 2);
        DeleteLocalObject(OBJECT_SELF, "StoredOffHand");
    }
    if (iNewOffHand)
    {
        ActionEquipItem(oLeft, INVENTORY_SLOT_LEFTHAND);
    }
    else if (GetIsObjectValid(oOrigLeft) && oOrigLeft == oLeft)
    {
        // nothing to do
    }
    else
    {
        EquipShield(bIndicateStatus);
    }
}


void EquipRangedWeapon(object oTarget, int bIndicateStatus, int iCallNumber = 1)
{
    if (!GetLocalInt(OBJECT_SELF, "UseRangedWeapons"))
    {
        return;
    }
    ActionEquipMostDamagingRanged(oTarget);
    int iCurAction = GetCurrentAction();
    if (iCurAction != ACTION_ATTACKOBJECT && iCurAction != ACTION_MOVETOPOINT
        && iCurAction != ACTION_FOLLOW && iCurAction != ACTION_INVALID)
    {
        return;
    }
    object oRight = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND);
    if (GetIsObjectValid(oRight) && !GetWeaponRanged(oRight))
    {
        if (iCallNumber < 2)
        {
            DelayCommand(2.5, EquipRangedWeapon(oTarget, bIndicateStatus, iCallNumber + 1));
        }
        else
        {
//            object oRealMaster = GetRealMaster();
//            if (GetIsObjectValid(oRealMaster) && GetIsPC(oRealMaster))
//            {
//                SpeakString(sHenchCantUseRanged);
//            }
            SetWeaponState(HENCH_AI_HAS_RANGED_WEAPON, FALSE);
            SetLocalInt(OBJECT_SELF, "UseRangedWeapons", FALSE);
            EquipMeleeWeapons(oTarget, bIndicateStatus);
        }
    }
}


//::///////////////////////////////////////////////
//:: Equip Appropriate Weapons
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Makes the user get his best weapons.  If the
    user is a Henchmen then he checks the player
    preference.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: April 2, 2002
//:://////////////////////////////////////////////

void HenchEquipAppropriateWeapons(object oTarget, float fThresholdDistance, int bIndicateSwitch, int bPolymorphed)
{
    if (bPolymorphed)
    {
        return;
    }
    int nWeaponStatus = GetInitWeaponStatus();
    int bUseRanged;

    if (nWeaponStatus & HENCH_AI_HAS_RANGED_WEAPON)
    {
        // has ranged weapons
        object oRealMaster = GetRealMaster();
        if(GetIsObjectValid(oRealMaster) && GetIsPC(oRealMaster) && !GetAssociateState(NW_ASC_USE_RANGED_WEAPON))
        {
            bUseRanged = FALSE;
        }
        else
        {
            if (nWeaponStatus & HENCH_AI_HAS_MELEE)
            {
                // if has melee weapons (includes creature weapons & monk class)
                // TODO add size of creatures for distance?
                bUseRanged = GetDistanceToObject(oTarget) > fThresholdDistance;
                // || (GetHasFeat(FEAT_POINT_BLANK_SHOT) && GetGameDifficulty() < GAME_DIFFICULTY_CORE_RULES);
            }
            else
            {
                bUseRanged = TRUE;
            }
        }
    }
    else
    {
        bUseRanged = FALSE;
    }
    if (bIndicateSwitch && GetAssociateState(NW_ASC_USE_RANGED_WEAPON))
    {
        if (!(nWeaponStatus & HENCH_AI_HAS_RANGED_WEAPON))
        {
            SetLocalInt(OBJECT_SELF, "SwitchedToMelee", FALSE);
        }
        else
        {
            int bSwitchedToMelee = GetLocalInt(OBJECT_SELF, "SwitchedToMelee");
            if (bUseRanged && bSwitchedToMelee)
            {
                SpeakString(sHenchSwitchToMissle);
                SetLocalInt(OBJECT_SELF, "SwitchedToMelee", FALSE);
            }
            else if (!bUseRanged && !bSwitchedToMelee)
            {
                SpeakString(sHenchSwitchToRanged);
                SetLocalInt(OBJECT_SELF, "SwitchedToMelee", TRUE);
            }
        }
    }
    SetLocalInt(OBJECT_SELF, "UseRangedWeapons", bUseRanged);
    if (bUseRanged)
    {
        object oRight = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND);
        int bOrigRanged = GetWeaponRanged(oRight);
        if (!bOrigRanged)
        {
            object oLeft = GetItemInSlot(INVENTORY_SLOT_LEFTHAND);
            if (GetIsObjectValid(oLeft))
            {
                // get rid of weapon or shield
                // shield or weapon in left hand prevents switch to ranged
                ActionUnequipItem(oLeft);
            }
        }
        EquipRangedWeapon(oTarget, bIndicateSwitch);
    }
    else
    {
        EquipMeleeWeapons(oTarget, bIndicateSwitch);
    }
}


void HenchEquipDefaultWeapons()
{
    HenchEquipAppropriateWeapons(OBJECT_SELF, -5., FALSE, GetHasEffect(EFFECT_TYPE_POLYMORPH));
}


void ClearWeaponStates()
{
    DeleteLocalInt(OBJECT_SELF, "SwitchedToMelee");
    DeleteLocalInt(OBJECT_SELF, "HaveShieldStatus");
    DeleteLocalObject(OBJECT_SELF, "StoredShield");
    DeleteLocalInt(OBJECT_SELF, "HaveOffhandStatus");
    DeleteLocalObject(OBJECT_SELF, "StoredOffHand");
    DeleteLocalInt(OBJECT_SELF, HENCH_AI_WEAPON);
}
