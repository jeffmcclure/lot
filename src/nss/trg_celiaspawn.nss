#include "inc_party"
void main()
{

object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;

if (!GetIsNight())
   return;

if (!(GetHitDice(oPC) >= 12))
   return;

int nInt;
nInt=GetPartyInt(oPC, "celia");
if (!(nInt == 0))
   return;

nInt=GetPartyInt(oPC, "caverns1");
if (!(nInt == 1))
   return;

object oTarget;
object oSpawn;
location lTarget;
oTarget = GetWaypointByTag("NIGHT_CELIA");
lTarget = GetLocation(oTarget);
oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "celia", lTarget);
SetPartyInt(oPC, "celia", 1);

}
