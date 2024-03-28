#include "inc_party"
void main()
{

object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_LOSTBOYS");
if (!(nInt > 3))
   return;

nInt=GetPartyInt(oPC, "deesegone");
if (!(nInt == 0))
   return;

nInt=GetPartyInt(oPC, "deesefinal");
if (!(nInt == 1))
   return;

object oTarget;
//object oTarget;
oTarget = GetObjectByTag("CAIN");
AdjustReputation(oPC, oTarget, 1);

oTarget = GetObjectByTag("DEESE");
DestroyObject(oTarget, 0.0);

oTarget = GetObjectByTag("BED_DEESE");
DestroyObject(oTarget, 0.0);

oTarget = GetObjectByTag("BED_ROOF");
DestroyObject(oTarget, 0.0);

oTarget = GetObjectByTag("BED_INNEAS");
DestroyObject(oTarget, 0.0);

SetPartyInt(oPC, "deesegone", 1);

}

