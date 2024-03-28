#include "nw_i0_tool"
void main()
{

object oPC = GetPCSpeaker();

object oItem;
oItem = GetItemPossessedBy(oPC, "D1_THEODORE");

if (GetIsObjectValid(oItem))
   DestroyObject(oItem);

RewardPartyXP(750, oPC, TRUE);
CreateItemOnObject("ringofelemental2", oPC);
AddJournalQuestEntry("QST_THEODORE", 2, oPC, TRUE, FALSE);

}
