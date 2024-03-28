// * Normal IQ + Is able to level up

#include "69_i0_henchman"

int StartingConditional()
{
    int iResult;
    // * April 20. this option should not even come up if the henchman is at max levels
    if (GetHitDice(OBJECT_SELF) < 20)  //changed to 20
    {
        iResult = CheckIntelligenceLow() && GetCanLevelUp(GetPCSpeaker());
    }
    else
    {
        iResult = FALSE;
    }
    return iResult;
}
