void main()
{

object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;

int DoOnce = GetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF));
if (DoOnce==TRUE) return;
SetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF), TRUE);

object oTarget;
oTarget = GetObjectByTag("TRISTRAM_2CATACOMBS");
SetLocked(oTarget, FALSE);
AssignCommand(oTarget, ActionOpenDoor(oTarget));
}
