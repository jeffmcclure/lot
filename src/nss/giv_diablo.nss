//#include "pqj_inc"
void main()
{

object oPC = GetPCSpeaker();

//AddPersistentJournalQuestEntry("QST_DIABLO", 1, oPC, TRUE, FALSE);
AddJournalQuestEntry("QST_DIABLO", 1, oPC, TRUE, FALSE);
//AddPersistentJournalQuestEntry("QST_MAINMODULE", 3, oPC, TRUE, FALSE);
AddJournalQuestEntry("QST_MAINMODULE", 3, oPC, TRUE, FALSE);
//ExecuteScript("sav_lastspeaker", OBJECT_SELF);

}

