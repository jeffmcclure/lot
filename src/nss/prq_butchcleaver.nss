int StartingConditional() {
    object oPC = GetPCSpeaker();
    return GetIsObjectValid(GetItemPossessedBy(oPC, "D1_BUTCHERSCLEAVER"));
}
