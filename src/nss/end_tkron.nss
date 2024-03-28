#include "inc_party"
#include "nw_i0_tool"
void main()
{

object oPC = GetPCSpeaker();

object oItem;
oItem = GetItemPossessedBy(oPC, "D1_THEBINDINGOFTHETHREE");
if (GetIsObjectValid(oItem))
   DestroyObject(oItem);

oItem = GetItemPossessedBy(oPC, "D1_THEDARKEXILE");
if (GetIsObjectValid(oItem))
   DestroyObject(oItem);

oItem = GetItemPossessedBy(oPC, "D1_THEGREATCONFLICT");
if (GetIsObjectValid(oItem))
   DestroyObject(oItem);

oItem = GetItemPossessedBy(oPC, "D1_THESINWAR");
if (GetIsObjectValid(oItem))
   DestroyObject(oItem);

oItem = GetItemPossessedBy(oPC, "D1_LAZARUSJOURNAL1");
if (GetIsObjectValid(oItem))
   DestroyObject(oItem);

oItem = GetItemPossessedBy(oPC, "D1_LAZARUSJOURNAL2");
if (GetIsObjectValid(oItem))
   DestroyObject(oItem);

oItem = GetItemPossessedBy(oPC, "D1_LAZARUSJOURNAL3");
if (GetIsObjectValid(oItem))
   DestroyObject(oItem);

RewardPartyXP(1000, oPC, TRUE);
CreateItemOnObject("tkronring", oPC);
AddJournalQuestEntry("QST_TKRON", 3, oPC, TRUE, FALSE);
SetPartyInt(oPC, "tkrontalk", 2);

}

