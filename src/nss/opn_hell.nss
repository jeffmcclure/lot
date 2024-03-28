#include "inc_party"
void main()
{

object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetPartyInt(oPC, "hell");
if (!(nInt == 0))
   return;

SetPartyInt(oPC, "hell", 1);

object oTarget;
object oSpawn;
location lTarget;

oTarget = GetWaypointByTag("HELL_FLAME_01");
lTarget = GetLocation(oTarget);
oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_flamelarge", lTarget);

oTarget = GetWaypointByTag("HELL_FLAME_02");
lTarget = GetLocation(oTarget);
oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_flamelarge", lTarget);

oTarget = GetWaypointByTag("HELL_FLAME_03");
lTarget = GetLocation(oTarget);
oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_flamelarge", lTarget);

oTarget = GetWaypointByTag("HELL_FLAME_04");
lTarget = GetLocation(oTarget);
oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_flamelarge", lTarget);

oTarget = GetWaypointByTag("HELL_FLAME_05");
lTarget = GetLocation(oTarget);
oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_flamelarge", lTarget);

oTarget = GetWaypointByTag("HELL_FLAME_06");
lTarget = GetLocation(oTarget);
oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_flamelarge", lTarget);

}
