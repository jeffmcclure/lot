#include "inc_party"
#include "x3_inc_string"

void OldAcquaintance(object obj) {
    string sTag=GetTag(obj);

    if (
        sTag == "ADRIA" ||
        sTag == "CAIN" ||
        sTag == "DEESE" ||
        sTag == "FARNHAM" ||
        sTag == "GARDA" ||
        sTag == "GILLIAN" ||
        sTag == "GRISWOLD" ||
        sTag == "LESTER" ||
        sTag == "NPC_GRANDMOTHER" ||
        sTag == "NPC_REMY" ||
        sTag == "NPC_THEEMON" ||
        sTag == "OGDEN" ||
        sTag == "PEPIN" ||
        sTag == "TREMAYNE" ||
        sTag == "WIRT" ||
        sTag == "COW"
        ) {
        object oPC=GetPCSpeaker();

        // only once per NPC
        if (GetLocalInt(obj, "OLD_ACQUAINTANCE") == 0) {
            SetLocalInt(obj, "OLD_ACQUAINTANCE", 1);

            json people = GetLocalJson(GetModule(), "CUSTOM30001");
            if (JSON_TYPE_NULL == JsonGetType(people)) {
                people = JsonParse("[\"Adria\", \"Cain\", \"Deese\", \"Farnham\", \"Garda\", \"Gillian\", \"Griswold\", \"Lester\", \"Gillian's Grandmother\", \"Remy\", \"TheeMon\", \"Ogden\", \"Pepin\", \"Tremayne\", \"Wirt\", \"The Cow\"]");
                //SendMessageToPC(GetFirstPC(), "create array " + IntToString(JsonGetType(people)));
                SetLocalJson(GetModule(), "CUSTOM30001", people);
            }

            // remove the person we spoke with
            int i=0;
            int len = JsonGetLength(people);
            string name = GetName(obj);
            for (i=0; i<len; i++) {
                string cmp = JsonGetString(JsonArrayGet(people, i));
                if (-1 != FindSubString(name, cmp)) {
                    people = JsonArrayDel(people, i);
                    SetLocalJson(GetModule(), "CUSTOM30001", people);
                    break;
                }
            }

            string remain = StringReplace(JsonDump(people), "\"", "");
            remain = StringReplace(remain, ",", ", ");
            remain = GetSubString(remain, 1, GetStringLength(remain) - 2);

            int remainCount = JsonGetLength(people);
            if (remainCount == 0) {
                AddJournalQuestEntry("QST_OLD_ACQUAINTANCE", 2, oPC, TRUE); // give to party
            } else {
                string msg;
                if (remainCount > 1)
                    msg = "  There are " + IntToString(remainCount) + " more people I must reacquaint myself with, they are: " + remain;
                 else
                    msg = "  There is one more people I must reacquaint myself with, it is " + remain;

                SetCustomToken(30000, msg);

                // need to remove and re-add so the custom token is re-generated into journal log entry
                RemoveJournalQuestEntry("QST_OLD_ACQUAINTANCE", oPC, TRUE); // give to party
                AddJournalQuestEntry("QST_OLD_ACQUAINTANCE", 1, oPC, TRUE); // give to party
                //SendMessageToPC(GetFirstPC(), "msg:" + msg);
            }
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
