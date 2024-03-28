//#include "pqj_inc"
#include "nw_i0_tool"
void main()
{

object oPC = GetPCSpeaker();

object oItem;
oItem = GetItemPossessedBy(oPC, "D1_GOLDENELIXIR");

if (GetIsObjectValid(oItem))
   DestroyObject(oItem);

RewardPartyXP(1500, oPC, TRUE);
RewardPartyGP(1500, oPC, TRUE);
CreateItemOnObject("veilofsteel", oPC);

//AddPersistentJournalQuestEntry("QST_LACHDANAN", 3, oPC, FALSE, FALSE);
AddJournalQuestEntry("QST_LACHDANAN", 3, oPC, TRUE, FALSE);
//ExecuteScript("sav_lastspeaker", OBJECT_SELF);

}
