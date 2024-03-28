//PUT THIS ON ACTION TAKEN OF THE SAME LINE
#include "inc_party"
#include "nw_i0_tool"
void main() {
    object oPC=GetPCSpeaker();

    // OBJECT_SELF is the NPC we are talking to
    string sTag=GetTag(OBJECT_SELF);

    SetPartyInt(oPC, sTag, 1);
    RewardPartyXP(250, oPC, TRUE);

    if (
        sTag == "ADRIA" ||
        sTag == "CAIN" ||
        sTag == "DEESE" ||
        sTag == "FARNHAM" ||
        sTag == "GARDA" ||
        sTag == "GILLIAN" ||
        sTag == "NPC_GRANDMOTHER" ||
        sTag == "GRISWOLD" ||
        sTag == "LESTER" ||
        sTag == "OGDEN" ||
        sTag == "PEPIN" ||
        sTag == "NPC_REMY" ||
        sTag == "TREMAYNE" ||
        sTag == "WIRT"
        ) {
        //int aint = GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_OLD_ACQUAINTANCE");
        //SendMessageToPC(GetFirstPC(), "int=" + IntToString(aint));
        AddJournalQuestEntry("QST_OLD_ACQUAINTANCE", GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_OLD_ACQUAINTANCE") + 1, oPC, TRUE); // give to party
    }
}
