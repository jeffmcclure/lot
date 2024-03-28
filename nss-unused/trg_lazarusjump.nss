void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

object oTarget;
oTarget = GetObjectByTag("NPC_LAZARUS");

AssignCommand(oTarget, ActionJumpToObject(GetObjectByTag("ALTAR_LAZARUS")));

}

