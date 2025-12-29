#include "loot_inc_gen_mod"

void main() {
    object oPC = GetFirstPC();

    string limitAcquire = GetLocalString(OBJECT_SELF, "LIMIT_ACQUIRE");
    object oChest = OBJECT_SELF;

    object oMember = GetFirstFactionMember(oPC, TRUE);
    while (GetIsObjectValid(oMember)) {
        if (GetName(oMember) == limitAcquire) {
            CreateLoot("butcherscleaver", oChest, oMember);
        }
        AssignCommand(oMember, ActionSpeakString("The spirits of the dead are now avenged..."));
        GiveXPToCreature(oMember, 750);
        oMember = GetNextFactionMember(oPC, TRUE);
    }

    AddJournalQuestEntry("QST_BUTCHER", 3, oPC, TRUE, FALSE);

    DestroyObject(GetObjectByTag("D1_WOUNDEDMAN"), 0.0);
    DestroyObject(GetObjectByTag("BUTCHER_BLOOD"), 0.0);
    SoundObjectStop(GetObjectByTag("SND_BUTCHER1"));
    SoundObjectStop(GetObjectByTag("SND_BUTCHER2"));
}
