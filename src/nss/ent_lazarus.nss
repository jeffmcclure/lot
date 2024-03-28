#include "pqj_inc"
void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYQST_BUTCHER");

if (!(nInt >= 2))
   return;

nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYQST_LAZARUS");

if (!(nInt < 1))
   return;

AddPersistentJournalQuestEntry("QST_LAZARUS", 1, oPC, FALSE, FALSE);

}

