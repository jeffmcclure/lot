#include "nw_i0_tool"
void main()
{

object oPC = GetPCSpeaker();

object oItem;
oItem = GetItemPossessedBy(oPC, "D1_DEFILERHEART");
if (GetIsObjectValid(oItem))
   DestroyObject(oItem);

RewardPartyXP(1000, oPC, TRUE);
CreateItemOnObject("mellosandals", oPC);
AddJournalQuestEntry("QST_MELLO", 3, oPC, TRUE, FALSE);
//SetLocalInt(oPC, "mellotalk", 3);

object oTarget;
oTarget = GetObjectByTag("CAIN");
AdjustReputation(oPC, oTarget, 1);

}

