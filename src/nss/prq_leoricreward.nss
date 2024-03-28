#include "inc_party"
int StartingConditional()
{
    if(!(GetPartyInt(GetPCSpeaker(), "leoric_reward") == 1))
        return FALSE;

    return TRUE;
}
