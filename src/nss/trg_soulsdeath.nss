void main() {
    object oPC = GetLastUsedBy();
    if (!GetIsPC(oPC)) return;

    string deadName = GetLocalString(OBJECT_SELF, "PLAYER_NAME");
    if (GetName(oPC) != deadName) {
        string msg = "RIP " + deadName;
        SendMessageToPC(oPC, msg);
        AssignCommand(oPC, ActionSpeakString(msg));
        return;
    }

    GiveXPToCreature(oPC, GetLocalInt(OBJECT_SELF, "DEATH_XP_PENALTY"));
    GiveGoldToCreature(oPC, GetLocalInt(OBJECT_SELF, "DEATH_GOLD_PENALTY"));
    DestroyObject(OBJECT_SELF);

    FloatingTextStringOnCreature("SOUL RETRIEVED", oPC, FALSE);
}
