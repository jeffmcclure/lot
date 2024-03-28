//Modified: NOV2002 69MEH69
#include "69_i0_henchman"

int StartingConditional()
{
    int iResult;

    iResult = GetFormerMaster() == GetPCSpeaker();
    return iResult;
}
