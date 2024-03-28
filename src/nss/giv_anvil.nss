//#include "pqj_inc"
void main()
{

object oPC = GetPCSpeaker();

//AddPersistentJournalQuestEntry("QST_ANVIL", 1, oPC, FALSE, FALSE);
AddJournalQuestEntry("QST_ANVIL", 1, oPC, TRUE, FALSE);
//ExecuteScript("sav_lastspeaker", OBJECT_SELF);

}

