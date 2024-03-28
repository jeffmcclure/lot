void main()
{

object oPC = GetFirstPC();
//while (GetIsObjectValid(GetMaster(oPC)))
//   {
//   oPC=GetMaster(oPC);
//   }
//
//if (!GetIsPC(oPC)) return;

AddJournalQuestEntry("QST_WORMS", 2, oPC, TRUE, FALSE);

object oTarget;
oTarget = GetObjectByTag("HOUSE_2WORMS1");
AssignCommand(oTarget, ActionCloseDoor(oTarget));
SetLocked(oTarget, TRUE);

}

