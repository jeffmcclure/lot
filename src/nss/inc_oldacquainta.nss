#include "inc_party"
void OldAcquaintance(object obj) {
    string sTag=GetTag(obj);
    object oPC = GetFirstPC();

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
        if (GetLocalInt(obj, "OLD_ACQUAINTANCE") == 0) {
            SetLocalInt(obj, "OLD_ACQUAINTANCE", 1);
            AddJournalQuestEntry("QST_OLD_ACQUAINTANCE", GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_OLD_ACQUAINTANCE") + 1, oPC, TRUE); // give to party
        }
    }
}