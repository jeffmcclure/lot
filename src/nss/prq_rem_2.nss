#include "inc_party"

int StartingConditional()
{
    return GetPartyInt(GetPCSpeaker(), "NW_JOURNAL_ENTRYQST_FIND_REMY") >= 2;
}
