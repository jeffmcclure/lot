#include "nw_i0_tool"
//#include "pqj_inc"
void main()
{

object oPC = GetPCSpeaker();

RewardPartyXP(1500, oPC, TRUE);
RewardPartyGP(2500, oPC, TRUE);
//AddPersistentJournalQuestEntry("QST_LOSTBOYS", 4, oPC, FALSE, FALSE);
AddJournalQuestEntry("QST_LOSTBOYS", 4, oPC, TRUE, FALSE);
//ExecuteScript("sav_lastspeaker", OBJECT_SELF);

}

