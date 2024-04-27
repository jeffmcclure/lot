void main() {
    SendMessageToPC(GetFirstPC(), "dth_generic_low");
    ExecuteScript("xp_partyextra", OBJECT_SELF);
    ExecuteScript("loot_normal_low", OBJECT_SELF);
}
