#include "inc_party"
#include "nw_i0_generic"
#include "x0_i0_partywide"
#include "inc_jeff"
void main() {
    SendMessageToPC(GetFirstPC(), "trg_spawnbutcher 1");

    DestroyAllByTag("KEY_BUTCHER");

    object oPC = GetLastOpenedBy();
    if (!GetIsPC(oPC)) return;
    SendMessageToPC(GetFirstPC(), "trg_spawnbutcher 2");

    int nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_BUTCHER");
    if (!(nInt >= 1))
        return;
    SendMessageToPC(GetFirstPC(), "trg_spawnbutcher 3");

    nInt=GetPartyInt(oPC, "butcher");
    if (!(nInt == 0))
        return;
    SendMessageToPC(GetFirstPC(), "trg_spawnbutcher 4");

    SetPartyInt(oPC, "butcher", 1);

    object oTarget = GetObjectByTag("SND_FRESHMEAT");
    AssignCommand(oTarget, ActionStartConversation(oPC, "con_butcher"));

    location lTarget = GetLocation(GetWaypointByTag("WP_BUTCHER"));

    object oMember=GetFirstFactionMember(oPC, TRUE);
    SendMessageToPC(GetFirstPC(), "trg_spawnbutcher 5");
    while (GetIsObjectValid(oMember)) {
    SendMessageToPC(GetFirstPC(), "trg_spawnbutcher 6");
        object oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "butcher001", lTarget);
        SetLocalString(oSpawn, "LIMIT_ACQUIRE", GetName(oMember));
        SetIsTemporaryEnemy(oPC, oSpawn);
        AssignCommand(oSpawn, ActionAttack(oPC));
        AssignCommand(oSpawn, DetermineCombatRound(oPC));
        oMember=GetNextFactionMember(oPC, TRUE);
    }
}
