void main()
{

object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYQST_LOSTBOYS");
if (!(nInt < 2))
   return;

AddJournalQuestEntry("QST_LOSTBOYS", 2, oPC, TRUE, FALSE);

}

