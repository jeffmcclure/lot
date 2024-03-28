//::///////////////////////////////////////////////
//:: FileName henchmanmng_arm
//:://////////////////////////////////////////////
//:: This script will cause the henchman to give the PC all their
//:: armor within a bag of holding. The PC will arrange the
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

    oBag = CreateItemOnObject(sBagTag, GetPCSpeaker(), 1);

    // If PC is low-level, the bag sometimes wont' identify for some reason.
    SetIdentified(oBag, TRUE);

    // The script henchmanequip will have to refer to this bag, so create
    // a pointer to it.
    SetLocalObject(OBJECT_SELF, "HenchBag", oBag);

    ClearAllActions();

    // First go through the backpack.

    // Now for some decency: we don't want the henchman to stand there
    // all naked (do we????), so we create a nice monk's outfit.
    object oDecency = GetLocalObject(OBJECT_SELF,"Decency");
    if (!GetIsObjectValid(oDecency) && GetIsHumanoid(GetRacialType(OBJECT_SELF)))
    {
        oDecency = CreateItemOnObject("NW_CLOTH016",OBJECT_SELF,1);
        DelayCommand(0.1,ActionEquipItem(oDecency,INVENTORY_SLOT_CHEST));
        SetLocalObject(OBJECT_SELF,"Decency",oDecency);
    }

    oItem = GetFirstItemInInventory(OBJECT_SELF);

    while (oItem != OBJECT_INVALID)
    {
        if (oItem != oDecency)
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
                TalentIdentifyItem(oItem);
                DelayCommand(0.2, ActionGiveItem(oItem, oBag));
                break;
            }
        }
        oItem = GetNextItemInInventory(OBJECT_SELF);
   }

    // Next go through all the equipped items. DO NOT transfer creature
    // items to the PC!
    for(i = 0; i < NUM_INVENTORY_SLOTS; ++i)
    {
        oItem = GetItemInSlot(i,OBJECT_SELF);
        if (oItem != OBJECT_INVALID && oItem != oDecency)
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
                SetIdentified(oItem, TRUE);
                SetIdentified(oItem, TRUE);                
                DelayCommand(0.2, ActionGiveItem(oItem, oBag));
                break;
            }
        }
    }
}
