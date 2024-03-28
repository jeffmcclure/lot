#include "inc_party"
void main()
{

object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetPartyInt(oPC, "andyenterclr");
if (!(nInt == 0))
   return;

nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_ANDARIEL");
if (!(nInt >= 1))
   return;

SetPartyInt(oPC, "andyenterclr", 1);

object oTarget;
oTarget = GetObjectByTag("CRYPTS_BOULDER_01");
DestroyObject(oTarget, 0.0);

oTarget = GetObjectByTag("CRYPTS_BOULDER_02");
DestroyObject(oTarget, 0.0);

oTarget = GetObjectByTag("CRYPTS_BOULDER_03");
DestroyObject(oTarget, 0.0);

oTarget = GetObjectByTag("CRYPTS_BOULDER_04");
DestroyObject(oTarget, 0.0);

}
