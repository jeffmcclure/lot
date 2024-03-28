// Starting Conditional script: tm_hirecheck
// Should only be placed in a henchman conversation file.
// This function returns TRUE if the henchman does not have a master.
//
// Written by: Celowin
// Last Updated: 7/25/02
//
int StartingConditional()
{
    int iResult;
    iResult = GetMaster()==OBJECT_INVALID;
    return iResult;
}

