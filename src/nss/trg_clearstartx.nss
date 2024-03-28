#include "inc_party"
void main()
{

object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;

int DoOnce = GetPartyInt(OBJECT_SELF, GetTag(OBJECT_SELF));
if (DoOnce==TRUE) return;
SetPartyInt(OBJECT_SELF, GetTag(OBJECT_SELF), TRUE);

object oTarget;

oTarget = GetObjectByTag("START_OX");
DestroyObject(oTarget, 0.0);
oTarget = GetObjectByTag("START_WAGON");
DestroyObject(oTarget, 0.0);
oTarget = GetObjectByTag("START_CAMPFIRE");
DestroyObject(oTarget, 0.0);
oTarget = GetObjectByTag("NPC_THEEMON");
DestroyObject(oTarget, 0.0);

}
