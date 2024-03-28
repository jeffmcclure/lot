//Modified: JUN2003 69MEH69
#include "69_i0_henchman"

int StartingConditional()
{
    int iResult;

    iResult = GetWorkingForPlayer(GetPCSpeaker()) == TRUE &&
        GetDidDie() == TRUE ;
    return iResult;
}

