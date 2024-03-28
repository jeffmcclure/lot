#include "inc_party"
void OldAcquaintance(object obj) {
    string sTag=GetTag(obj);

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
        //object oPC=GetFirstPC();
        object oPC=GetPCSpeaker();

        // only once per NPC
        if (GetLocalInt(obj, "OLD_ACQUAINTANCE") == 0) {
            SetLocalInt(obj, "OLD_ACQUAINTANCE", 1);
            AddJournalQuestEntry("QST_OLD_ACQUAINTANCE", GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_OLD_ACQUAINTANCE") + 1, oPC, TRUE); // give to party
        } else {
            // if player is missing quest, then copy from another player
            if (GetLocalInt(oPC, "NW_JOURNAL_ENTRYQST_OLD_ACQUAINTANCE") < 1) {
                int cur = GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_OLD_ACQUAINTANCE");
                if (cur > 0) {
                    AddJournalQuestEntry("QST_OLD_ACQUAINTANCE", cur, oPC, FALSE); // add to me only.  others already have
                }
            }
        }
    }
}