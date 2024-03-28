//::///////////////////////////////////////////////
//:: FileName henchmanmng_none
//:://////////////////////////////////////////////
//:: This script will cause the henchman to give the PC a bag of holding.
//:: The PC will add possessions to it,
//:: and then use dialog to give the bag back to the
//:: henchman.
//:://////////////////////////////////////////////
//:: Created By: Pausanias
//:://////////////////////////////////////////////

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

    // If PC is low-level, the bag sometimes won't identify for some reason.
    SetIdentified(oBag,TRUE);

    // The script henchmanequip will have to refer to this bag, so create
    // a pointer to it.
    SetLocalObject(OBJECT_SELF,"HenchBag",oBag);

}
