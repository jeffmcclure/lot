//::///////////////////////////////////////////////
//:: FileName henchmanfinish      v 0.9
//:://////////////////////////////////////////////
//:: This script will cause the henchman to get the items
//:: from the master's bag of holding (via henchmanxfer)
//::
//:://////////////////////////////////////////////
//:: Created By: Pausanias
//:: Created On: 6/28/2002 20:43:15
//:://////////////////////////////////////////////

#include "hench_i0_equip"
#include "hench_i0_henutil"

// Destroy the decency robe unless we're still wearing it.

void main()
{
    object oBag, oItem;
    int    i;

    // This is the bag created by the henchmanmanage or henchmanmng* scripts.
    oBag = GetLocalObject(OBJECT_SELF,"HenchBag");

    if (GetIsObjectValid(oBag))
    {
        object oItem = GetFirstItemInInventory(oBag);
        while (GetIsObjectValid(oItem))
        {            
            CopyItem(oItem, OBJECT_SELF);
            DestroyObject(oItem, 0.1);
            oItem = GetNextItemInInventory(oBag);
        }
        EquipItems(oBag);
        SetLocalInt(OBJECT_SELF,"HenchmanInv",0);
        // Destroy the monk's robe if it's there.
        DelayCommand(2.0, DestroyDecency(TRUE));

        // Destroy the bag of holding, with enough delay to allow smooth
        // transfer of the objects.
        // As of v0.9, this is now done by EquipItems.
        //DestroyObject(oBag,5.);        
        
        ClearWeaponStates();
        UnequipWeapons();
        DelayCommand(0.5, HenchEquipDefaultWeapons());
    }
}

