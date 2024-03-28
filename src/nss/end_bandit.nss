#include "nw_i0_tool"
//#include "pqj_inc"
void main()
{

object oPC = GetPCSpeaker();

object oItem;
oItem = GetItemPossessedBy(oPC, "D1_CORPSEVICO");

if (GetIsObjectValid(oItem))
   DestroyObject(oItem);

RewardPartyXP(750, oPC, TRUE);
RewardPartyGP(5000, oPC, TRUE);
//AddPersistentJournalQuestEntry("QST_BANDIT", 3, oPC, FALSE, FALSE);
AddJournalQuestEntry("QST_BANDIT", 3, oPC, TRUE, FALSE);
//ExecuteScript("sav_lastspeaker", OBJECT_SELF);

}

