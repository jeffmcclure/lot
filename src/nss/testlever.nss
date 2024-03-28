#include "nw_i0_generic"
#include "inc_party"
void main()
{

object oPC = GetLastUsedBy();

if (!GetIsPC(oPC)) return;

object oTarget;
oTarget = GetObjectByTag("NPC_DIABLO");
DestroyObject(oTarget, 0.0);

object oSpawn;
location lTarget;
oTarget = GetWaypointByTag("WP_DIABLO");
lTarget = GetLocation(oTarget);
oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "diablo", lTarget);
oTarget = oSpawn;
SetIsTemporaryEnemy(oPC, oTarget);
AssignCommand(oTarget, ActionAttack(oPC));
AssignCommand(oTarget, DetermineCombatRound(oPC));

SetPartyInt(oPC, "diablokill", 4);

oTarget = GetObjectByTag("PORTAL_TRISTRAM");
DestroyObject(oTarget, 0.0);

SendMessageToPC(oPC, "You need to pull one more lever to open up the remaining quadrant!");

}
