#include "inc_party"
int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int stat = GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_FIND_REMY");
    return stat == 2;
}
