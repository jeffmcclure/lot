#include "inc_party"

int StartingConditional() {
    object oPC = GetPCSpeaker();
    return GetPartyInt(oPC, "WIRT") > 0 && GetLocalInt(oPC, "NW_JOURNAL_ENTRYQST_LOOT_GENIE") < 1;
}
