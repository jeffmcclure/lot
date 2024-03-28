//#include "pqj_inc"
void main()
{

object oPC = GetPCSpeaker();

int nInt;
nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYQST_ARKAINE");
if (nInt < 1)
   {
   //AddPersistentJournalQuestEntry("QST_ARKAINE", 1, oPC, FALSE, FALSE);
   AddJournalQuestEntry("QST_ARKAINE", 1, oPC, TRUE, FALSE);
   //ExecuteScript("sav_lastspeaker", OBJECT_SELF);
   }
object oTarget;
oTarget = GetObjectByTag("DOOR_ARKAINE");
SetLocked(oTarget, FALSE);
AssignCommand(oTarget, ActionOpenDoor(oTarget));
}

