// Starting Conditional script: henchhire
// Should only be placed in a henchman conversation file.
// This function returns TRUE if the henchman does not have a master.
//
// Written by: Celowin
// Last Updated: 7/25/02
// Modified by: 69MEH69 03Sep2002
#include "69_inc_henai"
//#include "69_i0_henchman"

int StartingConditional()
{
    int iResult;

    if(GetCanWork(GetPCSpeaker(), OBJECT_SELF) == TRUE)
    {
     iResult = GetMaster()==OBJECT_INVALID;
    }
    else
    {
     iResult = FALSE;
    }
    return iResult;
}
