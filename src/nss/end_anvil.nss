//#include "pqj_inc"
#include "nw_i0_tool"
void main()
{

object oPC = GetPCSpeaker();

if (GetHasFeat(FEAT_WEAPON_PROFICIENCY_MONK, oPC))
   {
   RewardPartyXP(1500, oPC, TRUE);
   RewardPartyGP(1000, oPC, FALSE);
   CreateItemOnObject("griswoldsedge003", oPC);
   //AddPersistentJournalQuestEntry("QST_ANVIL", 3, oPC, FALSE, FALSE);
   AddJournalQuestEntry("QST_ANVIL", 3, oPC, TRUE, FALSE);
   //ExecuteScript("sav_lastspeaker", OBJECT_SELF);

   object oItem;
   oItem = GetItemPossessedBy(oPC, "D1_ANVILOFFURY");

   if (GetIsObjectValid(oItem))
    DestroyObject(oItem);

   }
else if (GetHasFeat(FEAT_WEAPON_PROFICIENCY_DRUID, oPC))
   {
   RewardPartyXP(1500, oPC, TRUE);
   RewardPartyGP(1000, oPC, FALSE);
   CreateItemOnObject("griswoldsedge004", oPC);
   //AddPersistentJournalQuestEntry("QST_ANVIL", 3, oPC, FALSE, FALSE);
   AddJournalQuestEntry("QST_ANVIL", 3, oPC, TRUE, FALSE);
   //ExecuteScript("sav_lastspeaker", OBJECT_SELF);

   object oItem;
   oItem = GetItemPossessedBy(oPC, "D1_ANVILOFFURY");

   if (GetIsObjectValid(oItem))
    DestroyObject(oItem);

   }
else if (GetHasFeat(FEAT_WEAPON_PROFICIENCY_ROGUE, oPC))
   {
   RewardPartyXP(1500, oPC, TRUE);
   RewardPartyGP(1000, oPC, FALSE);
   CreateItemOnObject("griswoldsedge005", oPC);
   //AddPersistentJournalQuestEntry("QST_ANVIL", 3, oPC, FALSE, FALSE);
   AddJournalQuestEntry("QST_ANVIL", 3, oPC, TRUE, FALSE);
   //ExecuteScript("sav_lastspeaker", OBJECT_SELF);

   object oItem;
   oItem = GetItemPossessedBy(oPC, "D1_ANVILOFFURY");

   if (GetIsObjectValid(oItem))
    DestroyObject(oItem);

   }
else if (GetHasFeat(FEAT_WEAPON_PROFICIENCY_WIZARD, oPC))
   {
   RewardPartyXP(1500, oPC, TRUE);
   RewardPartyGP(1000, oPC, FALSE);
   CreateItemOnObject("griswoldsedge002", oPC);
   //AddPersistentJournalQuestEntry("QST_ANVIL", 3, oPC, FALSE, FALSE);
   AddJournalQuestEntry("QST_ANVIL", 3, oPC, TRUE, FALSE);
   //ExecuteScript("sav_lastspeaker", OBJECT_SELF);

   object oItem;
   oItem = GetItemPossessedBy(oPC, "D1_ANVILOFFURY");

   if (GetIsObjectValid(oItem))
    DestroyObject(oItem);

   }
else
   {
   RewardPartyXP(1500, oPC, TRUE);
   RewardPartyGP(1000, oPC, FALSE);
   CreateItemOnObject("griswoldsedge", oPC);
   //AddPersistentJournalQuestEntry("QST_ANVIL", 3, oPC, FALSE, FALSE);
   AddJournalQuestEntry("QST_ANVIL", 3, oPC, TRUE, FALSE);
   //ExecuteScript("sav_lastspeaker", OBJECT_SELF);

   object oItem;
   oItem = GetItemPossessedBy(oPC, "D1_ANVILOFFURY");

   if (GetIsObjectValid(oItem))
    DestroyObject(oItem);

   }
}

