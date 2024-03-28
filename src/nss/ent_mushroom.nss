#include "inc_party"
void main()
{

object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_MUSHROOM");
if (!(nInt == 1))
   return;

nInt=GetPartyInt(oPC, "blackmushroom");
if (!(nInt == 0))
   return;

SetPartyInt(oPC, "blackmushroom", 1);

object oTarget;
object oSpawn;
location lTarget;
oTarget = GetWaypointByTag("WP_BLACKMUSHROOM");

lTarget = GetLocation(oTarget);

oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "zep_mushroom007", lTarget);

}
