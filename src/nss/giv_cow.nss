//#include "pqj_inc"
void main()
{

object oPC = GetPCSpeaker();
CreateItemOnObject("bottleofmilk", oPC);
//AddPersistentJournalQuestEntry("QST_COW", 1, oPC, FALSE, FALSE);
AddJournalQuestEntry("QST_COW", 1, oPC, TRUE, FALSE);
//ExecuteScript("sav_lastspeaker", OBJECT_SELF);

}

