//#include "inc_party"
string sDeny;
void main()
{

object oPC = GetLastUsedBy();

object oTarget;
oTarget = GetObjectByTag("DOOR_QUADRANT3A");

SetLocked(oTarget, FALSE);

AssignCommand(oTarget, ActionOpenDoor(oTarget));

oTarget = GetObjectByTag("DOOR_QUADRANT3B");

SetLocked(oTarget, FALSE);

AssignCommand(oTarget, ActionOpenDoor(oTarget));

oTarget = GetObjectByTag("DOOR_QUADRANT3C");

SetLocked(oTarget, FALSE);

AssignCommand(oTarget, ActionOpenDoor(oTarget));

oTarget = GetObjectByTag("DOOR_QUADRANT3D");

SetLocked(oTarget, FALSE);

AssignCommand(oTarget, ActionOpenDoor(oTarget));

//SetPartyInt(oPC, "diablokill", 3);

SendMessageToPC(oPC, "You hear doors opening up somewhere in the area...");

}
