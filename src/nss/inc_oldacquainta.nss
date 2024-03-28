#include "inc_party"
void OldAcquaintance(object oPC, string sTag) {
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
        sTag == "NPC_THEEMON" ||
        sTag == "TREMAYNE" ||
        sTag == "WIRT"
        ) {
        AddJournalQuestEntry("QST_OLD_ACQUAINTANCE", GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_OLD_ACQUAINTANCE") + 1, oPC, TRUE); // give to party
    }
}