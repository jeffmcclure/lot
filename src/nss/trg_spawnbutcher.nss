#include "inc_party"
#include "nw_i0_generic"
#include "x0_i0_partywide"
#include "inc_jeff"
void main() {
    //SendMessageToPC(GetFirstPC(), "trg_spawnbutcher 1");

    DestroyAllByTag("KEY_BUTCHER");

    object oPC = GetLastOpenedBy();
    if (!GetIsPC(oPC))
        oPC = GetFirstPC(); // this should not happen

    int nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_BUTCHER");
    if (nInt >= 2) return; // quest already active or done

    AddJournalQuestEntry("QST_BUTCHER", 2, oPC, TRUE, FALSE); // the butcher is out

    object oTarget = GetObjectByTag("SND_FRESHMEAT");
    AssignCommand(oTarget, ActionStartConversation(oPC, "con_butcher"));

    location lTarget = GetLocation(GetWaypointByTag("WP_BUTCHER"));
    object oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "butcher001", lTarget);

    SetLocalString(oSpawn, "LIMIT_ACQUIRE", GetName(oPC));
    SetIsTemporaryEnemy(oPC, oSpawn);
    AssignCommand(oSpawn, ActionAttack(oPC));
    AssignCommand(oSpawn, DetermineCombatRound(oPC));

    //object oMember=GetFirstFactionMember(oPC, TRUE);
    //while (GetIsObjectValid(oMember)) {
    //    object oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "butcher001", lTarget);
    //    SetLocalString(oSpawn, "LIMIT_ACQUIRE", GetName(oMember));
    //    SetIsTemporaryEnemy(oPC, oSpawn);
    //    AssignCommand(oSpawn, ActionAttack(oPC));
    //    AssignCommand(oSpawn, DetermineCombatRound(oPC));
    //    oMember=GetNextFactionMember(oPC, TRUE);
    //}
}
