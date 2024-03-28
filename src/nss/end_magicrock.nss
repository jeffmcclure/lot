//#include "pqj_inc"
#include "nw_i0_tool"
void main()
{

object oPC = GetPCSpeaker();

object oItem;
oItem = GetItemPossessedBy(oPC, "D1_HEAVENSTONE");

if (GetIsObjectValid(oItem))
   DestroyObject(oItem);

RewardPartyXP(750, oPC, TRUE);
CreateItemOnObject("empyreanband", oPC);
//AddPersistentJournalQuestEntry("QST_MAGICROCK", 3, oPC, FALSE, FALSE);
AddJournalQuestEntry("QST_MAGICROCK", 3, oPC, TRUE, FALSE);
//ExecuteScript("sav_lastspeaker", OBJECT_SELF);

}
