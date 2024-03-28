//#include "pqj_inc"
#include "inc_party"
void main()
{

object oPC = GetLastKiller();

while (GetIsObjectValid(GetMaster(oPC)))
   {
   oPC=GetMaster(oPC);
   }

if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_LOSTBOYS");

if (!(nInt == 2))
   return;

SetLocalInt(oPC, "warden", 1);
CreateItemOnObject("fencekey", oPC);
ActionSpeakString("Hahaha, my mistress Andariel will deal with you soon!");
//AddPersistentJournalQuestEntry("QST_ANDARIEL", 1, oPC, FALSE, FALSE);
AddJournalQuestEntry("QST_ANDARIEL", 1, oPC, TRUE, FALSE);
//ExecuteScript("sav_lastkilled", OBJECT_SELF);

}
