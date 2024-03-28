void main()
{

object oPC = GetFirstPC();

object oTarget;
oTarget = GetObjectByTag("DOOR_LAZARUS2");
SetLocked(oTarget, FALSE);
AssignCommand(oTarget, ActionOpenDoor(oTarget));

oTarget = GetObjectByTag("DOOR_LAZARUS3");
SetLocked(oTarget, FALSE);
AssignCommand(oTarget, ActionOpenDoor(oTarget));

//SendMessageToPC(oPC, "You hear a door opening somewhere in this area...");
AssignCommand(oPC, ActionSpeakString("I hear doors opening somewhere in this area..."));

}
