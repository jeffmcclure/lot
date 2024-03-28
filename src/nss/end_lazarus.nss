//#include "pqj_inc"
void main()
{

object oPC = GetFirstPC();

//int nInt;
//nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYQST_LAZARUS");

//if (!(nInt < 3))
//   return;

//AddPersistentJournalQuestEntry("QST_LAZARUS", 3, oPC, TRUE, FALSE);
AddJournalQuestEntry("QST_LAZARUS", 3, oPC, TRUE, FALSE);
AssignCommand(oPC, ActionSpeakString("Your madness ends here, betrayer!"));
//SendMessageToPC(oPC, "Your madness ends here, betrayer!");
//ExecuteScript("sav_lastkilled", OBJECT_SELF);

object oTarget;
oTarget = GetObjectByTag("");
MusicBackgroundStop(GetArea(oPC));

oTarget = GetObjectByTag("CAIN");
AdjustReputation(oPC, oTarget, 10);

}

