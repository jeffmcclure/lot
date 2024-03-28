//#include "pqj_inc"
void main()
{

object oPC = GetPCSpeaker();
//AddPersistentJournalQuestEntry("QST_MAINMODULE", 1, oPC, TRUE, FALSE);
AddJournalQuestEntry("QST_MAINMODULE", 1, oPC, TRUE, FALSE);
//ExecuteScript("sav_lastspeaker", OBJECT_SELF);

}
