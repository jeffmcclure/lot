//#include "pqj_inc"
#include "nw_i0_tool"
void main()
{

object oPC = GetPCSpeaker();

object oItem;
oItem = GetItemPossessedBy(oPC, "D1_ANVILOFFURY");

if (GetIsObjectValid(oItem))
   DestroyObject(oItem);

RewardPartyXP(1000, oPC, TRUE);
RewardPartyGP(1000, oPC, TRUE);
CreateItemOnObject("griswoldsedge018", oPC);
//AddPersistentJournalQuestEntry("QST_ANVIL", 3, oPC, FALSE, FALSE);
AddJournalQuestEntry("QST_ANVIL", 3, oPC, FALSE, FALSE);
//ExecuteScript("sav_lastspeaker", OBJECT_SELF);

}
