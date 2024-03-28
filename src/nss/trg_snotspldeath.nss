//#include "pqj_inc"
void main()
{

object oPC = GetFirstPC();
//while (GetIsObjectValid(GetMaster(oPC)))
//   {
//   oPC=GetMaster(oPC);
//   }
//
//if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYQST_OGDENSIGN");
if (!(nInt >= 1))
   return;

nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYQST_OGDENSIGN");
if (!(nInt < 2))
   return;

if (GetItemPossessedBy(oPC, "tavernsign")!= OBJECT_INVALID)
   return;

//SendMessageToPC(oPC, "The creature dropped a tavern sign! This must be the one stolen from Ogden!");

//CreateItemOnObject("tavernsign", oPC);

//AddPersistentJournalQuestEntry("QST_OGDENSIGN", 2, oPC, FALSE, FALSE);
AddJournalQuestEntry("QST_OGDENSIGN", 2, oPC, TRUE, FALSE);
//ExecuteScript("sav_lastkilled", OBJECT_SELF);

}
