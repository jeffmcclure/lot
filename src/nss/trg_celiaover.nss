#include "inc_party"
void main()
{

object oPC = GetExitingObject();
if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_THEODORE");

if (!(nInt >= 2))
   return;

nInt=GetPartyInt(oPC, "celiaover");

if (!(nInt == 0))
   return;

SetPartyInt(oPC, "celiaover", 1);
object oTarget;
oTarget = GetObjectByTag("CELIA");
DestroyObject(oTarget, 0.0);

}
