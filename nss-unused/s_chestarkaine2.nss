void main()
{
    object oPC = GetPCSpeaker();
    object oChest = OBJECT_SELF;
    SetLocked(oChest, FALSE);
    AssignCommand(oPC, DoPlaceableObjectAction(oChest, PLACEABLE_ACTION_USE));
    SetLocalInt(oChest, "arkaine_open", TRUE);
}
