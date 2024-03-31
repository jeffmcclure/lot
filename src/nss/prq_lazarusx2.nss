#include "inc_party"
int StartingConditional() {
    object oPC = GetPCSpeaker();

    return GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_LAZARUS") == 1;
}

