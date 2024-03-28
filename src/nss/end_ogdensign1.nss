#include "nw_i0_tool"
void main()
{

object oPC = GetPCSpeaker();

int nInt;
nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_MAGICBANNER");
if (nInt >= 1)
   {
   RewardPartyXP(1000, oPC, TRUE);
   RewardPartyGP(750, oPC, TRUE);
   CreateItemOnObject("harlequincrest", oPC);
   AdjustAlignment(oPC, ALIGNMENT_GOOD, 2);

   object oItem;
   oItem = GetItemPossessedBy(oPC, "D1_TAVERNSIGN");

   if (GetIsObjectValid(oItem))
      DestroyObject(oItem);

   AddJournalQuestEntry("QST_OGDENSIGN", 2, oPC, TRUE, FALSE);
   AddJournalQuestEntry("QST_MAGICBANNER", 3, oPC, TRUE, FALSE);

   }
else
   {
   RewardPartyXP(1000, oPC, TRUE);
   RewardPartyGP(750, oPC, TRUE);
   CreateItemOnObject("harlequincrest", oPC);

   object oItem;
   oItem = GetItemPossessedBy(oPC, "D1_TAVERNSIGN");

   if (GetIsObjectValid(oItem))
      DestroyObject(oItem);

   AddJournalQuestEntry("QST_OGDENSIGN", 2, oPC, TRUE, FALSE);

   }
}
