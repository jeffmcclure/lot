#include "69_inc_henai"
//#include "69_i0_henchman"

int StartingConditional()
{
    int iResult;

    if(GetCanWork(GetPCSpeaker(), OBJECT_SELF) == FALSE)
    {
     iResult = TRUE;
    }
    else
    {
     iResult = FALSE;
    }
    return iResult;
}
