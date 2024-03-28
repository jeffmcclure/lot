#include "inc_party"
void main()
{

object oPC = GetPCSpeaker();

int nInt;
nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_BLIND");
if (nInt == 1)
   {
   //AddPersistentJournalQuestEntry("QST_BLIND", 2, oPC, FALSE, FALSE);
   AddJournalQuestEntry("QST_BLIND", 2, oPC, TRUE, FALSE);
   //ExecuteScript("sav_lastspeaker", OBJECT_SELF);
   object oTarget;
   oTarget = GetObjectByTag("CATACOMBS3_2BLIND");
   SetLocked(oTarget, FALSE);
   AssignCommand(oTarget, ActionOpenDoor(oTarget));
   }
}

