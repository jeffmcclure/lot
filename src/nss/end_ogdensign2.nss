#include "nw_i0_tool"
#include "inc_party"
void main()
{

object oPC = GetPCSpeaker();

int nInt;
nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_MAGICBANNER");
if (nInt >= 1)
   {
   RewardPartyXP(1500, oPC, TRUE);
   RewardPartyGP(750, oPC, TRUE);
   AdjustAlignment(oPC, ALIGNMENT_GOOD, 5);
   //CreateItemOnObject("harlequincrest", oPC);

   object oItem;
   oItem = GetItemPossessedBy(oPC, "D1_TAVERNSIGN");

   if (GetIsObjectValid(oItem))
      DestroyObject(oItem);

   AddJournalQuestEntry("QST_OGDENSIGN", 2, oPC, TRUE, FALSE);
   AddJournalQuestEntry("QST_MAGICBANNER", 3, oPC, TRUE, FALSE);

   }
else
   {
   RewardPartyXP(1500, oPC, TRUE);
   RewardPartyGP(750, oPC, TRUE);
   //CreateItemOnObject("harlequincrest", oPC);

   object oItem;
   oItem = GetItemPossessedBy(oPC, "D1_TAVERNSIGN");

   if (GetIsObjectValid(oItem))
      DestroyObject(oItem);

   AddJournalQuestEntry("QST_OGDENSIGN", 2, oPC, TRUE, FALSE);

   }
}
