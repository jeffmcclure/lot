void main()
{

object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;

if (GetItemPossessedBy(oPC, "D1_CATACOMBSTONE")== OBJECT_INVALID)
   return;

object oTarget;
oTarget = GetObjectByTag("TRISTRAM_2CATACOMBS");
SetLocked(oTarget, FALSE);
AssignCommand(oTarget, ActionOpenDoor(oTarget));
}
