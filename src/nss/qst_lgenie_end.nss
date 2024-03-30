void main() {
    object oPC = GetPCSpeaker();

    // Complete loot genie quest
    AddJournalQuestEntry("QST_LOOT_GENIE", 2, GetPCSpeaker(), FALSE, FALSE); // only give to player not party

    // Give loot genie
    object obj = CreateItemOnObject("lootgenie", oPC);
    SetPlotFlag(obj, TRUE);  // set resale value to zero

    // destroy two baubles
    int nItems = 0;
    object oItem = GetFirstItemInInventory(oPC);
    while (GetIsObjectValid(oItem)) {
        if ("WIRT_BAUBLE" == GetTag(oItem)) {
            nItems = nItems + 1;
            DestroyObject(oItem, 0.1);
        }

        if (nItems >= 2) break;
        oItem = GetNextItemInInventory(oPC);
    }

}
