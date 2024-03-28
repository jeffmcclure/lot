int StartingConditional() {
    object oPC = GetPCSpeaker();
    if (1 != GetLocalInt(oPC, "NW_JOURNAL_ENTRYQST_LOOT_GENIE")) return FALSE;

    int nItems = 0;
    object oItem = GetFirstItemInInventory(oPC);
    while (GetIsObjectValid(oItem)) {
        if ("WIRT_BAUBLE" == GetTag(oItem)) {
            nItems = nItems + 1;
            if (nItems == 2) return TRUE;
        }
        oItem = GetNextItemInInventory(oPC);
    }

    return FALSE;
}
