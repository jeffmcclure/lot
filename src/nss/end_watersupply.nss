//#include "pqj_inc"
#include "nw_i0_tool"
void main()
{

object oPC = GetPCSpeaker();

//SetLocalInt(oPC, "watersupplyquest", 5);

RewardPartyXP(1000, oPC, TRUE);
RewardPartyGP(500, oPC, FALSE);
CreateItemOnObject("ringoftruth", oPC);

//AddPersistentJournalQuestEntry("QST_WATERSUPPLY", 3, oPC, FALSE, FALSE);
AddJournalQuestEntry("QST_WATERSUPPLY", 3, oPC, TRUE, FALSE);
//ExecuteScript("sav_lastspeaker", OBJECT_SELF);

}
