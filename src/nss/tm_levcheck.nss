// Starting Conditional script: tm_henchlev
// Should only be put into a conversation file for a henchman
//
// Returns TRUE if the henchman is ready to level up.
//
#include "tm_henchlib"
//
int StartingConditional()
{
    int iResult;
    object oHench=GetHenchman(GetPCSpeaker());
    iResult = GetReadyToLevel(oHench)==TRUE;
    return iResult;
}

