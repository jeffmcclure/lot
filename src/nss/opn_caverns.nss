#include "inc_party"
void main()
{

object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;

int DoOnce = GetPartyInt(OBJECT_SELF, GetTag(OBJECT_SELF));
if (DoOnce==TRUE) return;
SetPartyInt(OBJECT_SELF, GetTag(OBJECT_SELF), TRUE);

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
