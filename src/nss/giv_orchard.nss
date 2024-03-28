//#include "pqj_inc"
void main()
{

object oPC = GetPCSpeaker();
CreateItemOnObject("cowbomb", oPC);
//AddPersistentJournalQuestEntry("QST_COW", 1, oPC, FALSE, FALSE);
AddJournalQuestEntry("QST_ORCHARD", 1, oPC, TRUE, FALSE);
//ExecuteScript("sav_lastspeaker", OBJECT_SELF);

}

