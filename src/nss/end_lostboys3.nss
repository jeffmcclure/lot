#include "nw_i0_tool"
//#include "pqj_inc"
void main()
{

object oPC = GetPCSpeaker();

RewardPartyXP(2500, oPC, TRUE);
RewardPartyGP(3500, oPC, FALSE);
//AddPersistentJournalQuestEntry("QST_LOSTBOYS", 5, oPC, FALSE, FALSE);
AddJournalQuestEntry("QST_LOSTBOYS", 5, oPC, TRUE, FALSE);
//ExecuteScript("sav_lastspeaker", OBJECT_SELF);

}

