//#include "pqj_inc"
#include "nw_i0_tool"
void main()
{

object oPC = GetPCSpeaker();

object oItem;
oItem = GetItemPossessedBy(oPC, "D1_ANVILOFFURY");

if (GetIsObjectValid(oItem))
   DestroyObject(oItem);

RewardPartyXP(1000, oPC, FALSE);
RewardPartyGP(1000, oPC, FALSE);
CreateItemOnObject("griswoldsedge010", oPC);
//AddPersistentJournalQuestEntry("QST_ANVIL", 3, oPC, FALSE, FALSE);
AddJournalQuestEntry("QST_ANVIL", 3, oPC, FALSE, FALSE);
//ExecuteScript("sav_lastspeaker", OBJECT_SELF);

}
