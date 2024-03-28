#include "nw_i0_tool"
void main()
{

object oPC = GetPCSpeaker();

object oItem;
oItem = GetItemPossessedBy(oPC, "D1_CORPSEFARNHAM");

if (GetIsObjectValid(oItem))
   DestroyObject(oItem);

RewardPartyXP(2500, oPC, TRUE);
AddJournalQuestEntry("QST_ISLAND", 4, oPC, TRUE, FALSE);

}

