#include "nw_i0_generic"
#include "inc_party"
string sDeny;
void main()
{

object oPC = GetLastUsedBy();

if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetLocalInt(oPC, "diablokill");

if (!(nInt == 3))
   {
   sDeny="The lever won't budge. You might need to pull another lever before this one...";

   SendMessageToPC(oPC, sDeny);

   return;
   }

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
