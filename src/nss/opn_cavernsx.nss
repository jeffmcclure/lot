void main()
{

object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;

if (GetItemPossessedBy(oPC, "spell_soulstone")== OBJECT_INVALID)
   return;

object oTarget;
oTarget = GetObjectByTag("C_BOULDER_01");
DestroyObject(oTarget, 0.0);

oTarget = GetObjectByTag("C_BOULDER_02");
DestroyObject(oTarget, 0.0);

oTarget = GetObjectByTag("C_BOULDER_03");
DestroyObject(oTarget, 0.0);

oTarget = GetObjectByTag("C_BOULDER_04");
DestroyObject(oTarget, 0.0);

oTarget = GetObjectByTag("C_BOULDER_05");
DestroyObject(oTarget, 0.0);

oTarget = GetObjectByTag("C_BOULDER_06");
DestroyObject(oTarget, 0.0);

}
