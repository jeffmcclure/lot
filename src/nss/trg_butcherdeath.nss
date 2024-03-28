#include "nw_i0_tool"
void main() {

    object oPC = GetFirstPC();

    RewardPartyXP(750, oPC, TRUE);
    object cleaver = CreateItemOnObject("butcherscleaver", OBJECT_SELF);
    SetLocalString(cleaver, "LIMIT_ACQUIRE", GetLocalString(OBJECT_SELF, "LIMIT_ACQUIRE"));
    AddJournalQuestEntry("QST_BUTCHER", 2, oPC, TRUE, FALSE);
    AssignCommand(oPC, ActionSpeakString("The spirits of the dead are now avenged..."));

    DestroyObject(GetObjectByTag("D1_WOUNDEDMAN"), 0.0);
    DestroyObject(GetObjectByTag("BUTCHER_BLOOD"), 0.0);
    SoundObjectStop(GetObjectByTag("SND_BUTCHER1"));
    SoundObjectStop(GetObjectByTag("SND_BUTCHER2"));
}
