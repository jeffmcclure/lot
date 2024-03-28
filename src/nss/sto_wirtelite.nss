void main()
{
    object oPC = GetPCSpeaker();
    AssignCommand(oPC, TakeGoldFromCreature(2500, oPC, TRUE));

    object oStore = GetNearestObjectByTag("STO_WIRTELITESTORE");
    if (GetObjectType(oStore) == OBJECT_TYPE_STORE)
    {
        OpenStore(oStore, GetPCSpeaker());
    }
    else
    {
        //ActionSpeakStringByStrRef(53090, TALKVOLUME_TALK);
        AssignCommand(GetObjectByTag("WIRT"), ActionSpeakString("W-what? Come back tomorrow!"));
    }
}
