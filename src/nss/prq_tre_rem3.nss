#include "inc_party"
#include "nw_i0_tool"
void main() {
    object oPC = GetPCSpeaker();
    AddJournalQuestEntry("QST_FIND_REMY", 3, oPC);
    RewardPartyXP(200, oPC);
}
