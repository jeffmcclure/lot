//::///////////////////////////////////////////////
//:: nw_O0_LevelUp.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
 This script fires whenever a player levels up.
 If the henchmen is capable of going up a level, they do.
*/
//:://////////////////////////////////////////////
//:: Created By:     Brent
//:: Created On:     2002
//:://////////////////////////////////////////////
#include "hench_i0_equip"
#include "hench_i0_henlvl"


void main()
{
    object oPC = GetPCLevellingUp();
    if (GetIsObjectValid(oPC) == TRUE)
    {
            // Copy familiar/animal companion's inventory.
        CopyFamiliarAnimalCompanionItems(oPC);
        
        object oHench = GetHenchman(oPC);
        if (GetIsObjectValid(oHench))
        {
    // Auldar: Results from running henchauldar are required for GetCanLevelUp to be accurate
    // I had to make changes to accomodate the presence or absense of my modified resrefs
            ExecuteScript("henchauldar",oHench);
            if (GetCanLevelUp(oPC, oHench))
            {
                SetAssociateState(NW_ASC_IS_BUSY);
                object oNew = DoLevelUp(oPC, oHench);
                if (GetIsObjectValid(oNew) == TRUE)
                {
                    AssignCommand(oNew,DelayCommand(5.0, HenchEquipAppropriateWeapons(oNew, -5., FALSE, FALSE)));
                }
            }
        }
    }
}
