#include "inc_party"
int StartingConditional()
{

    // Inspect local variables
    if(!(GetPartyInt(GetPCSpeaker(), "andariel") == 1))
        return FALSE;

    return TRUE;
}
