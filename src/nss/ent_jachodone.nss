#include "inc_party"
void main()
{

object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_BANDIT");
if (!(nInt < 3))
   return;

nInt=GetPartyInt(oPC, "jacholast");
if (!(nInt == 0))
   return;

object oTarget;
object oSpawn;
location lTarget;
oTarget = GetWaypointByTag("WP_JACHO2_01");
lTarget = GetLocation(oTarget);
oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "jacho_done", lTarget);

SetPartyInt(oPC, "jacholast", 1);

}
