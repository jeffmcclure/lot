//#include "pqj_inc"
#include "nw_i0_tool"
void main()
{

object oPC = GetPCSpeaker();

RewardPartyXP(1500, oPC, TRUE);
RewardPartyGP(750, oPC, TRUE);

object oItem;
oItem = GetItemPossessedBy(oPC, "D1_TAVERNSIGN");

if (GetIsObjectValid(oItem))
   DestroyObject(oItem);

//AddPersistentJournalQuestEntry("QST_OGDENSIGN", 3, oPC, FALSE, FALSE);
AddJournalQuestEntry("QST_OGDENSIGN", 3, oPC, TRUE, FALSE);
//ExecuteScript("sav_lastspeaker", OBJECT_SELF);

}
