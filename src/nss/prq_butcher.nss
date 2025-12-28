int StartingConditional() {
    object oPC = GetPCSpeaker();

    // read from user, not party
    return GetLocalInt(oPC, "NW_JOURNAL_ENTRYQST_BUTCHER") < 1;
}
