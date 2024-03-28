//#include "pqj_inc"
#include "nw_i0_tool"
void main()
{

object oPC = GetPCSpeaker();

RewardPartyXP(750, oPC, TRUE);
RewardPartyGP(1000, oPC, TRUE);
//AddPersistentJournalQuestEntry("QST_LEORIC", 3, oPC, FALSE, FALSE);
AddJournalQuestEntry("QST_LEORIC", 3, oPC, TRUE, FALSE);
//ExecuteScript("sav_lastspeaker", OBJECT_SELF);

object oTarget;
oTarget = GetObjectByTag("CAIN");
AdjustReputation(oPC, oTarget, 2);

}
