// Starting Conditional script: mastercheck
// Should only be placed in a henchman conversation file.
// This function returns TRUE if the pc speaking is not the henchman’s
// current master.
//
// Written by: Celowin
// Last Updated: 7/25/02
//
#include "69_inc_henai"

int StartingConditional()
{
    int iResult;
    iResult = GetPCSpeaker()!= GetRealMaster();
    GiveXPToCreature(OBJECT_SELF,500);
    SendMessageToPC(GetFirstPC(),GetName(OBJECT_SELF) + " XP: " + IntToString(GetXP(OBJECT_SELF)));
    return iResult;
}

