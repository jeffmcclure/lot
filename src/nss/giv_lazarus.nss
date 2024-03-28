//#include "pqj_inc"
void main()
{

object oPC = GetPCSpeaker();

//AddPersistentJournalQuestEntry("QST_LAZARUS", 2, oPC, TRUE, FALSE);
AddJournalQuestEntry("QST_LAZARUS", 2, oPC, TRUE, FALSE);
//AddPersistentJournalQuestEntry("QST_MAINMODULE", 2, oPC, TRUE, FALSE);
AddJournalQuestEntry("QST_MAINMODULE", 2, oPC, TRUE, FALSE);
//ExecuteScript("sav_lastspeaker", OBJECT_SELF);

}
