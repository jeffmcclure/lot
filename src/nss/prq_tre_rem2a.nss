#include "inc_party"
int StartingConditional()
{
    int stat = GetPartyInt(GetPCSpeaker(), "NW_JOURNAL_ENTRYQST_FIND_REMY");
    return stat == 1;
}

