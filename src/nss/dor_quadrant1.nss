string sDeny;
void main()
{

object oPC = GetLastUsedBy();

object oTarget;
oTarget = GetObjectByTag("DOOR_QUADRANT2A");

SetLocked(oTarget, FALSE);

AssignCommand(oTarget, ActionOpenDoor(oTarget));

oTarget = GetObjectByTag("DOOR_QUADRANT2B");

SetLocked(oTarget, FALSE);

AssignCommand(oTarget, ActionOpenDoor(oTarget));

oTarget = GetObjectByTag("DOOR_QUADRANT2C");

SetLocked(oTarget, FALSE);

AssignCommand(oTarget, ActionOpenDoor(oTarget));

SendMessageToPC(oPC, "You hear doors opening up somewhere in the area..");

}
