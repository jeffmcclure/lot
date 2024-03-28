#include "nw_i0_tool"
void main()
{

object oPC = GetPCSpeaker();
object oItem;
oItem = GetItemPossessedBy(oPC, "D1_IRAQOIL");

if (GetIsObjectValid(oItem))
   DestroyObject(oItem);
RewardPartyXP(500, oPC, TRUE);
AddJournalQuestEntry("QST_IRAQ", 2, oPC, TRUE, FALSE);

}

