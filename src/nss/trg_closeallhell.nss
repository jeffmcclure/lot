void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

object oTarget;
oTarget = GetObjectByTag("DOOR_QUADRANT2A");

AssignCommand(oTarget, ActionCloseDoor(oTarget));

SetLocked(oTarget, TRUE);

oTarget = GetObjectByTag("DOOR_QUADRANT2B");

AssignCommand(oTarget, ActionCloseDoor(oTarget));

SetLocked(oTarget, TRUE);

oTarget = GetObjectByTag("DOOR_QUADRANT2C");

AssignCommand(oTarget, ActionCloseDoor(oTarget));

SetLocked(oTarget, TRUE);

oTarget = GetObjectByTag("DOOR_QUADRANT3A");

AssignCommand(oTarget, ActionCloseDoor(oTarget));

SetLocked(oTarget, TRUE);

oTarget = GetObjectByTag("DOOR_QUADRANT3B");

AssignCommand(oTarget, ActionCloseDoor(oTarget));

SetLocked(oTarget, TRUE);

oTarget = GetObjectByTag("DOOR_QUADRANT3C");

AssignCommand(oTarget, ActionCloseDoor(oTarget));

SetLocked(oTarget, TRUE);

oTarget = GetObjectByTag("DOOR_QUADRANT3D");

AssignCommand(oTarget, ActionCloseDoor(oTarget));

SetLocked(oTarget, TRUE);

}

