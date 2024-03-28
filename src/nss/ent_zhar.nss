#include "inc_party"
void main()
{

object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetPartyInt(oPC, "zhar");
if (!(nInt == 0))
   return;

nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_ZHAR");
if (!(nInt < 1))
   return;

object oTarget;
object oSpawn;
location lTarget;
oTarget = GetWaypointByTag("WP_ZHAR");
lTarget = GetLocation(oTarget);
oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "zharthemad", lTarget);
oTarget = oSpawn;
AssignCommand(oTarget, ActionStartConversation(oPC, ""));
SetPartyInt(oPC, "zhar", 1);

}

