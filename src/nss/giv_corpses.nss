//#include "pqj_inc"
void main()
{

object oPC = GetPCSpeaker();

CreateItemOnObject("corpseroofx", oPC);
CreateItemOnObject("corpseinneasx", oPC);
//AddPersistentJournalQuestEntry("QST_LOSTBOYS", 3, oPC, FALSE, FALSE);
AddJournalQuestEntry("QST_LOSTBOYS", 3, oPC, TRUE, FALSE);
//ExecuteScript("sav_lastspeaker", OBJECT_SELF);

}

