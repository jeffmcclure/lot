#include "69_inc_henai"
// * Is the PCSpeaker
// * the Henchman's master?
int StartingConditional()
{
    int iResult;

    // MR: changed GetMaster to GetRealMaster
    iResult = GetRealMaster(OBJECT_SELF) == GetPCSpeaker();
    return iResult;
}
