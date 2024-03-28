#include "inc_party"
void main()
{

object oPC = GetExitingObject();
if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_COW");
if (!(nInt == 2))
   return;

nInt=GetPartyInt(oPC, "cowquest");
if (!(nInt == 0))
   return;

object oTarget;
oTarget = GetObjectByTag("COW");
DestroyObject(oTarget, 0.0);

object oSpawn;
location lTarget;
oTarget = GetWaypointByTag("POST_COWMAN");

lTarget = GetLocation(oTarget);
oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "completenut2", lTarget);

SetPartyInt(oPC, "cowquest", 1);

}
