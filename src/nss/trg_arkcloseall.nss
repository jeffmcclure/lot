void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

object oTarget;
oTarget = GetObjectByTag("DOOR_ARKAINE2");

AssignCommand(oTarget, ActionCloseDoor(oTarget));

SetLocked(oTarget, TRUE);

oTarget = GetObjectByTag("DOOR_ARKAINE3");

AssignCommand(oTarget, ActionCloseDoor(oTarget));

SetLocked(oTarget, TRUE);

oTarget = GetObjectByTag("DOOR_ARKAINEVALOR");

AssignCommand(oTarget, ActionCloseDoor(oTarget));

SetLocked(oTarget, TRUE);

}
