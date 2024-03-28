// This conditional determines if this henchman is currently
// not actively hired by anyone.

#include "x0_i0_henchman"

int StartingConditional()
{
    if (!GetIsHired())
        return TRUE;

    return FALSE;
}
