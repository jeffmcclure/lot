void GenLootForEachPlayer(string lootResRef, object targetContainer) {
    object oPC = GetFirstPC();
    object oMember = GetFirstFactionMember(oPC, TRUE);
    while (GetIsObjectValid(oMember)) {
        string charName = GetName(oMember);
        SendMessageToPC(oPC, "charName='" + charName + "'");
        object newLoot = CreateItemOnObject(lootResRef, targetContainer);
        SetIdentified(newLoot, TRUE);
        SetLocalString(newLoot, "LIMIT_ACQUIRE", charName);
        oMember = GetNextFactionMember(oPC, TRUE);
    }
}