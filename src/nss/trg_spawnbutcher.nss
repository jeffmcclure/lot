#include "inc_party"
#include "nw_i0_generic"
#include "x0_i0_partywide"
#include "inc_jeff"
void main() {

    DestroyAllByTag("KEY_BUTCHER");

    object oPC = GetLastOpenedBy();
    if (!GetIsPC(oPC)) return;

    int nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_BUTCHER");
    if (!(nInt >= 1))
        return;

    nInt=GetPartyInt(oPC, "butcher");
    if (!(nInt == 0))
        return;

    SetPartyInt(oPC, "butcher", 1);

    object oTarget = GetObjectByTag("SND_FRESHMEAT");
    AssignCommand(oTarget, ActionStartConversation(oPC, "con_butcher"));

    location lTarget = GetLocation(GetWaypointByTag("WP_BUTCHER"));

    object oMember=GetFirstFactionMember(oPC, TRUE);
    while (GetIsObjectValid(oMember)) {
        object oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "butcher001", lTarget);
        SetLocalString(oSpawn, "LIMIT_ACQUIRE", GetName(oMember));
        SetIsTemporaryEnemy(oPC, oSpawn);
        AssignCommand(oSpawn, ActionAttack(oPC));
        AssignCommand(oSpawn, DetermineCombatRound(oPC));
        oMember=GetNextFactionMember(oPC, TRUE);
    }
}
