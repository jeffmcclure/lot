#include "pqj_inc"
void main()
{

object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;

if (GetItemPossessedBy(oPC, "EPIC_EPICTOTEM")== OBJECT_INVALID)
   return;

int nInt;
nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYQST_CORNERSTONE");
if (!(nInt < 1))
   return;

AddPersistentJournalQuestEntry("QST_CORNERSTONE", 1, oPC, TRUE, FALSE);
//ExecuteScript("sav_lastenter", OBJECT_SELF);

}
