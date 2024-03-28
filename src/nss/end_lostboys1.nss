#include "nw_i0_tool"
//#include "pqj_inc"
void main()
{

object oPC = GetPCSpeaker();

object oItem;
oItem = GetItemPossessedBy(oPC, "D1_CORPSEROOF");

if (GetIsObjectValid(oItem))
   DestroyObject(oItem);

oItem = GetItemPossessedBy(oPC, "D1_CORPSEINNEAS");

if (GetIsObjectValid(oItem))
   DestroyObject(oItem);

RewardPartyXP(2000, oPC, TRUE);
RewardPartyGP(5000, oPC, TRUE);
//AddPersistentJournalQuestEntry("QST_LOSTBOYS", 4, oPC, FALSE, FALSE);
AddJournalQuestEntry("QST_LOSTBOYS", 4, oPC, TRUE, FALSE);
//ExecuteScript("sav_lastspeaker", OBJECT_SELF);

}

