//#include "pqj_inc"
#include "nw_i0_tool"
string sDeny;
void main()
{

object oPC = GetFirstPC();

RewardPartyXP(2000, oPC, TRUE);
//RewardPartyGP(20000, oPC, TRUE);
//AddPersistentJournalQuestEntry("QST_WARLORD", 3, oPC, FALSE, FALSE);
AddJournalQuestEntry("QST_WARLORD", 3, oPC, TRUE, FALSE);
//ExecuteScript("sav_lastkilled", OBJECT_SELF);

}
