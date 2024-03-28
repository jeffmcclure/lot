void main()
{
    object oStore = GetNearestObjectByTag("WirtsRogueStore");
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
