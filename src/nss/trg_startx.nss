#include "inc_party"
#include "nw_i0_tool"
void main() {
    object oPC = GetPCSpeaker();
    string sTag=GetTag(OBJECT_SELF); // OBJECT_SELF is the NPC we are talking to; GetTag() returns "NPC_THEEMON" for example
    SetLocalInt(oPC, sTag, 1);
    RewardPartyXP(250, oPC, TRUE);
    AddJournalQuestEntry("QST_MAINMODULE", 1, oPC, FALSE, FALSE); // only give to player not party
    AddJournalQuestEntry("QST_WELCOME_BACK", 2, oPC, FALSE, FALSE); // only give to player not party
}
