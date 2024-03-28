void main()
{

object oPC = GetFirstPC();

object oTarget;
oTarget = GetObjectByTag("DOOR_LAZARUS4");
SetLocked(oTarget, FALSE);
AssignCommand(oTarget, ActionOpenDoor(oTarget));

//SendMessageToPC(oPC, "You hear the doors opening somewhere in this area...");
AssignCommand(oPC, ActionSpeakString("I hear a door opening somewhere in this area..."));

}
