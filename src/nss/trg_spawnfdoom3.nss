#include "inc_party"
#include "nw_i0_generic"
void main()
{

object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_FLESHDOOM");
if (!(nInt >= 1))
   return;

nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_FLESHDOOM");
if (!(nInt < 3))
   return;

nInt=GetPartyInt(oPC, "fleshdoom");
if (!(nInt == 0))
   return;

SetPartyInt(oPC, "fleshdoom", 1);

object oTarget;
object oSpawn;
location lTarget;
oTarget = GetWaypointByTag("WP_FLESHDOOM3");
lTarget = GetLocation(oTarget);
oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "fleshdoom", lTarget);
oTarget = oSpawn;
AssignCommand(oTarget, ActionStartConversation(oPC, ""));

}
