#include "x0_i0_henchman"

void main()
{
object oPC = GetPCSpeaker();

//check to see if taghor is in 1st hench slot
object oTarget1=GetHenchman(oPC,1);

if (GetTag(oTarget1)=="taghor")
    {
    // strip hench and drop
    // Removing henches equipment.
    object oGear = GetItemInSlot(INVENTORY_SLOT_ARMS, oTarget1);
    if(GetIsObjectValid(oGear))
        ActionTakeItem(oGear, oTarget1);
    oGear = GetItemInSlot(INVENTORY_SLOT_BELT, oTarget1);
    if(GetIsObjectValid(oGear))
        ActionTakeItem(oGear, oTarget1);
    oGear = GetItemInSlot(INVENTORY_SLOT_BOLTS, oTarget1);
    if(GetIsObjectValid(oGear))
       ActionTakeItem(oGear, oTarget1);
    oGear = GetItemInSlot(INVENTORY_SLOT_BOOTS, oTarget1);
    if(GetIsObjectValid(oGear))
       ActionTakeItem(oGear, oTarget1);
    oGear = GetItemInSlot(INVENTORY_SLOT_CHEST, oTarget1);
    if(GetIsObjectValid(oGear))
        ActionTakeItem(oGear, oTarget1);
    oGear = GetItemInSlot(INVENTORY_SLOT_CLOAK, oTarget1);
    if(GetIsObjectValid(oGear))
        ActionTakeItem(oGear, oTarget1);
    oGear = GetItemInSlot(INVENTORY_SLOT_HEAD, oTarget1);
    if(GetIsObjectValid(oGear))
       ActionTakeItem(oGear, oTarget1);
    oGear = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oTarget1);
    if(GetIsObjectValid(oGear))
      ActionTakeItem(oGear, oTarget1);
    oGear = GetItemInSlot(INVENTORY_SLOT_LEFTRING, oTarget1);
    if(GetIsObjectValid(oGear))
       ActionTakeItem(oGear, oTarget1);
    oGear = GetItemInSlot(INVENTORY_SLOT_NECK, oTarget1);
    if(GetIsObjectValid(oGear))
       ActionTakeItem(oGear, oTarget1);
    oGear = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oTarget1);
    if(GetIsObjectValid(oGear))
       ActionTakeItem(oGear, oTarget1);
    oGear = GetItemInSlot(INVENTORY_SLOT_RIGHTRING, oTarget1);
    if(GetIsObjectValid(oGear))
       ActionTakeItem(oGear, oTarget1);
    oGear = GetItemInSlot(INVENTORY_SLOT_ARROWS, oTarget1);
    if(GetIsObjectValid(oGear))
       ActionTakeItem(oGear, oTarget1);
    oGear = GetItemInSlot(INVENTORY_SLOT_BOLTS, oTarget1);
    if(GetIsObjectValid(oGear))
        ActionTakeItem(oGear, oTarget1);
    oGear = GetItemInSlot(INVENTORY_SLOT_BULLETS, oTarget1);
    if(GetIsObjectValid(oGear))
       ActionTakeItem(oGear, oTarget1);
    // Removing hench's inventory.
    object oStuff = GetFirstItemInInventory(oTarget1);
    while(GetIsObjectValid(oStuff))
    {
        ActionTakeItem(oStuff, oTarget1);
        oStuff = GetNextItemInInventory(oTarget1);
    }

    DelayCommand(5.0, RemoveHenchman(oPC, oTarget1));
    object ohench_heartbeat_controlblock = GetObjectByTag("hench_heartbeat_controlblock");
    SetLocalInt(ohench_heartbeat_controlblock, "Taghor has been replaced by another henchman", 1);
    //DelayCommand(6.0, DestroyObject(oTarget1));
    }


//check to see if taghor is in 2nd hench slot
object oTarget2=GetHenchman(oPC,2);

if (GetTag(oTarget2)=="taghor")
   {

    object oGear = GetItemInSlot(INVENTORY_SLOT_ARMS, oTarget2);
    if(GetIsObjectValid(oGear))
       ActionTakeItem(oGear, oTarget2);
    oGear = GetItemInSlot(INVENTORY_SLOT_BELT, oTarget2);
    if(GetIsObjectValid(oGear))
      ActionTakeItem(oGear, oTarget2);
    oGear = GetItemInSlot(INVENTORY_SLOT_BOLTS, oTarget2);
    if(GetIsObjectValid(oGear))
       ActionTakeItem(oGear, oTarget2);
    oGear = GetItemInSlot(INVENTORY_SLOT_BOOTS, oTarget2);
    if(GetIsObjectValid(oGear))
       ActionTakeItem(oGear, oTarget2);
    oGear = GetItemInSlot(INVENTORY_SLOT_CHEST, oTarget2);
    if(GetIsObjectValid(oGear))
        ActionTakeItem(oGear, oTarget2);
    oGear = GetItemInSlot(INVENTORY_SLOT_CLOAK, oTarget2);
    if(GetIsObjectValid(oGear))
      ActionTakeItem(oGear, oTarget2);
    oGear = GetItemInSlot(INVENTORY_SLOT_HEAD, oTarget2);
    if(GetIsObjectValid(oGear))
     ActionTakeItem(oGear, oTarget2);
    oGear = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oTarget2);
    if(GetIsObjectValid(oGear))
       ActionTakeItem(oGear, oTarget2);
    oGear = GetItemInSlot(INVENTORY_SLOT_LEFTRING, oTarget2);
    if(GetIsObjectValid(oGear))
         ActionTakeItem(oGear, oTarget2);
    oGear = GetItemInSlot(INVENTORY_SLOT_NECK, oTarget2);
    if(GetIsObjectValid(oGear))
        ActionTakeItem(oGear, oTarget2);
    oGear = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oTarget2);
    if(GetIsObjectValid(oGear))
       ActionTakeItem(oGear, oTarget2);
    oGear = GetItemInSlot(INVENTORY_SLOT_RIGHTRING, oTarget2);
    if(GetIsObjectValid(oGear))
      ActionTakeItem(oGear, oTarget2);
    oGear = GetItemInSlot(INVENTORY_SLOT_ARROWS, oTarget2);
    if(GetIsObjectValid(oGear))
      ActionTakeItem(oGear, oTarget2);
    oGear = GetItemInSlot(INVENTORY_SLOT_BOLTS, oTarget2);
    if(GetIsObjectValid(oGear))
      ActionTakeItem(oGear, oTarget2);
    oGear = GetItemInSlot(INVENTORY_SLOT_BULLETS, oTarget2);
    if(GetIsObjectValid(oGear))
      ActionTakeItem(oGear, oTarget2);
    // Removing hench's inventory.
    object oStuff = GetFirstItemInInventory(oTarget2);
    while(GetIsObjectValid(oStuff))
    {
      ActionTakeItem(oStuff, oTarget2);
      oStuff = GetNextItemInInventory(oTarget2);
    }

    DelayCommand(5.0, RemoveHenchman(oPC, oTarget2));
    object ohench_heartbeat_controlblock = GetObjectByTag("hench_heartbeat_controlblock");
    SetLocalInt(ohench_heartbeat_controlblock, "Taghor has been replaced by another henchman", 1);
    //DelayCommand(6.0, DestroyObject(oTarget2));
    }

}

