#include "inc_party"
#include "nw_i0_generic"
#include "x0_i0_partywide"
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

location lTarget;
oTarget = GetWaypointByTag("WP_BUTCHER");
lTarget = GetLocation(oTarget);

object oMember=GetFirstFactionMember(oPC, TRUE);
while (GetIsObjectValid(oMember)) {
    object oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "butcher001", lTarget);
    SetIsTemporaryEnemy(oPC, oSpawn);
    AssignCommand(oSpawn, ActionAttack(oPC));
    AssignCommand(oSpawn, DetermineCombatRound(oPC));
    oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "butcher001", lTarget);
    SetIsTemporaryEnemy(oPC, oSpawn);
    AssignCommand(oSpawn, ActionAttack(oPC));
    AssignCommand(oSpawn, DetermineCombatRound(oPC));
    oMember=GetNextFactionMember(oPC, TRUE);
}

//ExecuteScript("xp_partyextra", OBJECT_SELF);

}

