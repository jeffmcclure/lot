//#include "pqj_inc"
#include "nw_i0_tool"
void main()
{

object oPC = GetPCSpeaker();

RewardPartyXP(1000, oPC, TRUE);
CreateItemOnObject("spectralelixir", oPC);
//AddPersistentJournalQuestEntry("QST_MUSHROOM", 5, oPC, FALSE, FALSE);
AddJournalQuestEntry("QST_MUSHROOM", 5, oPC, TRUE, FALSE);
//ExecuteScript("sav_lastspeaker", OBJECT_SELF);

object oTarget;
oTarget = GetObjectByTag("CAIN");
AdjustReputation(oPC, oTarget, 1);

}
