//::///////////////////////////////////////////////
//:: FileName henchshowinv
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 6/29/2003 8:25:51 PM
//:://////////////////////////////////////////////

#include "hench_i0_equip"

void main()
{
    ClearWeaponStates();
    
        // prevent problem with OC henchman and
        // non identified items
    int i;
    for(i = 0; i < NUM_INVENTORY_SLOTS; ++i)
    {
        object oItem = GetItemInSlot(i);
        if (oItem != OBJECT_INVALID)
        {
            switch (GetBaseItemType(oItem))
            {
            case BASE_ITEM_CREATUREITEM:
            case BASE_ITEM_CBLUDGWEAPON:
            case BASE_ITEM_CSLASHWEAPON:
            case BASE_ITEM_CSLSHPRCWEAP:
            case BASE_ITEM_CPIERCWEAPON:
                break;
            default:
                SetIdentified(oItem, TRUE);
                break;
            }
        }
    }
    
    OpenInventory(OBJECT_SELF, GetPCSpeaker());
}

