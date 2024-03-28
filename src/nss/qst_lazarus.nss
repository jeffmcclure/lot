//#include "pqj_inc"
void main()
{

object oPC = GetPCSpeaker();
//AddPersistentJournalQuestEntry("QST_LAZARUS", 1, oPC, TRUE, FALSE);
AddJournalQuestEntry("QST_LAZARUS", 1, oPC, TRUE, FALSE);

}
