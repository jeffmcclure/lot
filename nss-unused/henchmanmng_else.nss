//::///////////////////////////////////////////////
//:: FileName henchmanmng_else
//:://////////////////////////////////////////////
//:: This script will cause the henchman to give the PC all their non-armor
//:: possessions within a bag of holding. The PC will arrange the
//:: possessions, and then use dialog to give the bag back to the
//:: henchman.
//:://////////////////////////////////////////////
//:: Created By: Pausanias
//:://////////////////////////////////////////////

#include "hench_i0_ident"

#include "hench_i0_generic"

void main()
{
    object oItem, oBag;
    int    i;

    // Set the variables
    // This variable is checked for in dialogue. HenchmanInv = 1
    // means that the PC has the Henchman's inventory.
    SetLocalInt(OBJECT_SELF, "HenchmanInv", 1);

    // Give the PC a bag of holding or other container.
    ExecuteScript("henchbagtype",OBJECT_SELF);
    string sBagTag = GetLocalString(OBJECT_SELF,"ContainerType");
    if (GetStringLength(sBagTag) < 2) sBagTag = "NW_IT_CONTAIN006";

    oBag = CreateItemOnObject(sBagTag,GetPCSpeaker(),1);

    // If PC is low-level, the bag sometimes wont' identify for some reason.
    SetIdentified(oBag,TRUE);

    // The script henchmanequip will have to refer to this bag, so create
    // a pointer to it.
    SetLocalObject(OBJECT_SELF,"HenchBag",oBag);

    // First go through the backpack.

    oItem = GetFirstItemInInventory(OBJECT_SELF);

    while (oItem != OBJECT_INVALID)
    {
        switch (GetBaseItemType(oItem))
        {
            case BASE_ITEM_ARMOR:
            case BASE_ITEM_CLOAK:
            case BASE_ITEM_BOOTS:
            case BASE_ITEM_HELMET:
            case BASE_ITEM_SMALLSHIELD:
            case BASE_ITEM_LARGESHIELD:
            case BASE_ITEM_TOWERSHIELD:
                break;
            case BASE_ITEM_DAGGER:
                // prevent pixie dagger from being given up
                if (!GetDroppableFlag(oItem))
                {
                    break;
                }
            default:
                TalentIdentifyItem(oItem);
                DelayCommand(0.2, ActionGiveItem(oItem, oBag));
                break;
        }
        oItem = GetNextItemInInventory(OBJECT_SELF);
    }

    // Next go through all the equipped items. DO NOT transfer creature
    // items to the PC!
    ClearAllActions();

    for(i = 0; i < NUM_INVENTORY_SLOTS; ++i)
    {
        oItem = GetItemInSlot(i,OBJECT_SELF);
        if (oItem != OBJECT_INVALID)
        {
            switch (GetBaseItemType(oItem))
            {
                case BASE_ITEM_ARMOR:
                case BASE_ITEM_CLOAK:
                case BASE_ITEM_BOOTS:
                case BASE_ITEM_CREATUREITEM:
                case BASE_ITEM_CBLUDGWEAPON:
                case BASE_ITEM_CSLASHWEAPON:
                case BASE_ITEM_CSLSHPRCWEAP:
                case BASE_ITEM_CPIERCWEAPON:
                case BASE_ITEM_HELMET:
                case BASE_ITEM_SMALLSHIELD:
                case BASE_ITEM_LARGESHIELD:
                case BASE_ITEM_TOWERSHIELD:
                    break;
                case BASE_ITEM_DAGGER:
                    // prevent pixie dagger from being given up
                    if (!GetDroppableFlag(oItem))
                    {
                        break;
                    }
                default:                
                    SetIdentified(oItem, TRUE);                
                    DelayCommand(0.2, ActionGiveItem(oItem, oBag));
                    break;
            }
        }
    }
}

