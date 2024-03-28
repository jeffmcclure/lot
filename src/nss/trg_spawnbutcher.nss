#include "inc_party"
#include "nw_i0_generic"
void main()
{

object oPC = GetLastOpenedBy();
if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_BUTCHER");
if (!(nInt >= 1))
   return;

nInt=GetPartyInt(oPC, "butcher");
if (!(nInt == 0))
   return;

SetPartyInt(oPC, "butcher", 1);

object oTarget;
oTarget = GetObjectByTag("SND_FRESHMEAT");
AssignCommand(oTarget, ActionStartConversation(oPC, "con_butcher"));

object oSpawn;
location lTarget;
oTarget = GetWaypointByTag("WP_BUTCHER");
lTarget = GetLocation(oTarget);
oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "butcher001", lTarget);
oTarget = oSpawn;
SetIsTemporaryEnemy(oPC, oTarget);
AssignCommand(oTarget, ActionAttack(oPC));
AssignCommand(oTarget, DetermineCombatRound(oPC));

//ExecuteScript("xp_partyextra", OBJECT_SELF);

}

