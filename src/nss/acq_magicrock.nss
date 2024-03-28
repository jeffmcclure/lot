#include "inc_party"
string sDeny;
void main()
{

object oPC = GetLastUsedBy();
if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_MAGICROCK");
if (!(nInt >= 1))
   {
   sDeny="There is nothing useful on this corpse...";
   SendMessageToPC(oPC, sDeny);
   return;
   }

nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_MAGICROCK");
if (!(nInt < 3))
   {
   sDeny="There is nothing useful on this corpse...";
   SendMessageToPC(oPC, sDeny);
   return;
   }

if (GetItemPossessedBy(oPC, "D1_HEAVENSTONE")!= OBJECT_INVALID)
   {
   sDeny="You already have the heaven stone...";
   SendMessageToPC(oPC, sDeny);
   return;
   }

CreateItemOnObject("heavenstone", oPC);
//AddPersistentJournalQuestEntry("QST_MAGICROCK", 2, oPC, FALSE, FALSE);
AddJournalQuestEntry("QST_MAGICROCK", 2, oPC, FALSE, FALSE);
//ExecuteScript("sav_lastused", OBJECT_SELF);

}
