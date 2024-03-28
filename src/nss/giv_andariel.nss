//#include "pqj_inc"
void main()
{

object oPC = GetPCSpeaker();

//AddPersistentJournalQuestEntry("QST_ANDARIEL", 2, oPC, FALSE, FALSE);
AddJournalQuestEntry("QST_ANDARIEL", 2, oPC, TRUE, FALSE);
//ExecuteScript("sav_lastspeaker", OBJECT_SELF);

}

