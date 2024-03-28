void main()
{

object oPC = GetPCSpeaker();

AddJournalQuestEntry("QST_WORMS", 1, oPC, TRUE, FALSE);

object oTarget;
oTarget = GetObjectByTag("TRISTRAM_2FARNHAM");
SetLocked(oTarget, FALSE);
AssignCommand(oTarget, ActionOpenDoor(oTarget));

}
