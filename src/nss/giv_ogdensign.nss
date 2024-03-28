//#include "pqj_inc"
void main()
{

object oPC = GetPCSpeaker();

//AddPersistentJournalQuestEntry("QST_OGDENSIGN", 1, oPC, TRUE, FALSE);
AddJournalQuestEntry("QST_OGDENSIGN", 1, oPC, TRUE, FALSE);
//ExecuteScript("sav_lastspeaker", OBJECT_SELF);

}

