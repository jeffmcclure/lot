//#include "pqj_inc"
void main()
{

object oPC = GetPCSpeaker();

int nInt;
nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYQST_CHAMBER");
if (nInt < 1)
   {
   //AddPersistentJournalQuestEntry("QST_CHAMBER", 1, oPC, FALSE, FALSE);
   AddJournalQuestEntry("QST_CHAMBER", 1, oPC, TRUE, FALSE);
   //ExecuteScript("sav_lastspeaker", OBJECT_SELF);
   }
//object oTarget;
//oTarget = GetObjectByTag("CATACOMBS2_2CHAMBER");
//SetLocked(oTarget, FALSE);
//AssignCommand(oTarget, ActionOpenDoor(oTarget));
}

