int StartingConditional() {
    return GetItemPossessedBy(GetPCSpeaker(), "spell_soulstone") != OBJECT_INVALID;
}
