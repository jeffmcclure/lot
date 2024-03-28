//#include "pqj_inc"
void main()
{

object oPC = GetPCSpeaker();

CreateItemOnObject("corpsevico", oPC);
//AddPersistentJournalQuestEntry("QST_BANDIT", 2, oPC, FALSE, FALSE);
AddJournalQuestEntry("QST_BANDIT", 2, oPC, TRUE, FALSE);
//ExecuteScript("sav_lastspeaker", OBJECT_SELF);

}

