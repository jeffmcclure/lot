void main()
{

object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;
if (GetItemPossessedBy(oPC, "shadowfang")== OBJECT_INVALID)
   return;

object oTarget;
oTarget = GetObjectByTag("CAIN");

AdjustReputation(oPC, oTarget, -1);
AdjustAlignment(oPC, ALIGNMENT_EVIL, 1);
FloatingTextStringOnCreature("The demon blade you carry is slowly corrupting you...", oPC);

}
