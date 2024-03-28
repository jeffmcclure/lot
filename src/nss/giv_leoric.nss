//#include "pqj_inc"
void main()
{

object oPC = GetPCSpeaker();

//AddPersistentJournalQuestEntry("QST_LEORIC", 1, oPC, FALSE, FALSE);
AddJournalQuestEntry("QST_LEORIC", 1, oPC, TRUE, FALSE);
//ExecuteScript("sav_lastspeaker", OBJECT_SELF);
object oTarget;
oTarget = GetObjectByTag("CHURCH3_2LEORIC");
SetLocked(oTarget, FALSE);
}

