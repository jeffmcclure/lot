void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

object oTarget;
oTarget = GetObjectByTag("DOOR_ARKAINE2");

SetLocked(oTarget, FALSE);

AssignCommand(oTarget, ActionOpenDoor(oTarget));

}
