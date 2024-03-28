int StartingConditional() {
    object oPC = GetPCSpeaker();

    return (GetLocalInt(oPC, "NW_JOURNAL_ENTRYQST_MAINMODULE") < 1);
}
