#include "inc_party"
void main()
{

object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_LOSTBOYS");
if (!(nInt >= 2))
   return;

object oTarget;
oTarget = GetObjectByTag("2TEMPLE1_BOULDER1");
DestroyObject(oTarget, 0.0);

oTarget = GetObjectByTag("2TEMPLE1_BOULDER2");
DestroyObject(oTarget, 0.0);

oTarget = GetObjectByTag("2TEMPLE1_BOULDER3");
DestroyObject(oTarget, 0.0);

oTarget = GetObjectByTag("2TEMPLE1_BOULDER4");
DestroyObject(oTarget, 0.0);

oTarget = GetObjectByTag("2TEMPLE2_BOULDER1");
DestroyObject(oTarget, 0.0);

oTarget = GetObjectByTag("2TEMPLE2_BOULDER2");
DestroyObject(oTarget, 0.0);

oTarget = GetObjectByTag("2TEMPLE2_BOULDER3");
DestroyObject(oTarget, 0.0);

oTarget = GetObjectByTag("2TEMPLE2_BOULDER4");
DestroyObject(oTarget, 0.0);

}
