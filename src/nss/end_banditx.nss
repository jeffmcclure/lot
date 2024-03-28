#include "nw_i0_tool"
//#include "pqj_inc"
void main()
{

object oPC = GetPCSpeaker();

RewardPartyXP(500, oPC, TRUE);
RewardPartyGP(1000, oPC, TRUE);
//AddPersistentJournalQuestEntry("QST_JOURNAL", 3, oPC, FALSE, FALSE);
AddJournalQuestEntry("QST_JOURNAL", 3, oPC, TRUE, FALSE);
//ExecuteScript("sav_lastspeaker", OBJECT_SELF);

}

