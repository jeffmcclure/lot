void main()
{
    object oPC = GetPCSpeaker();
    object oChest = OBJECT_SELF;
    AssignCommand(oPC, DoPlaceableObjectAction(oChest, PLACEABLE_ACTION_USE));
}

