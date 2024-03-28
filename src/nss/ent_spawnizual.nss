#include "inc_party"
void main()
{

object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_IZUAL");
if (!(nInt >= 2))
   return;

nInt=GetPartyInt(oPC, "izualspawn");
if (!(nInt == 0))
   return;

SetPartyInt(oPC, "izualspawn", 1);

object oTarget;
object oSpawn;
location lTarget;
oTarget = GetWaypointByTag("WP_IZUAL");
lTarget = GetLocation(oTarget);
oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "izual001", lTarget);
oTarget = oSpawn;

AssignCommand(oTarget, ActionStartConversation(oPC, ""));

}

