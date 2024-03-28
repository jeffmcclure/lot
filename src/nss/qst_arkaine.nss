#include "nw_i0_tool"
#include "inc_party"

void trgArkaine(string objToCreate, object oPC) {
    object obj = CreateItemOnObject(objToCreate, oPC);
    SetIdentified(obj,TRUE);

    // script is called when each user gets their armor, so distribute rewards just to the one PC
    RewardPartyXP(1500, oPC, FALSE);
    RewardPartyGP(1000, oPC, FALSE);
    AddJournalQuestEntry("QST_ARKAINE", 3, oPC, FALSE, FALSE);
    AssignCommand(oPC, ActionSpeakString("May the spirit of our king protect me!"));

    //Visual effects can't be applied to waypoints, so if it is a WP apply to the WP's location instead

    int nInt = GetObjectType(oPC);

    if (nInt != OBJECT_TYPE_WAYPOINT)
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_WORD), oPC);
     else
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_WORD), GetLocation(oPC));
 }

 void main() {
    object oPC = GetLastUsedBy();
    if (!GetIsPC(oPC)) return;

    // Use Local here to avoid duplicate issuance
    int nInt = GetLocalInt(oPC, "NW_JOURNAL_ENTRYQST_ARKAINE");

    if (nInt >= 3) {
       sDeny="There is nothing else interesting in this vault.";
       SendMessageToPC(oPC, sDeny);
       return;
    }

    // Use Party here in case the PC was absent when quest updated
    nInt = GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_ARKAINE");
    if (nInt >= 2) {
        if (GetHasFeat(FEAT_ARMOR_PROFICIENCY_HEAVY, oPC)) {
           trgArkaine("arkainesvalor", oPC);
        } else if (GetHasFeat(FEAT_ARMOR_PROFICIENCY_MEDIUM, oPC)) {
           trgArkaine("arkainesvalor3", oPC);
        } else if (GetHasFeat(FEAT_ARMOR_PROFICIENCY_LIGHT, oPC)) {
           trgArkaine("arkainesvalor2", oPC);
        } else {
           trgArkaine("arkainesvalor4", oPC);
        }
    } else {
       sDeny="You need to talk to Cain first...";
       SendMessageToPC(oPC, sDeny);
       return;
    }

}
