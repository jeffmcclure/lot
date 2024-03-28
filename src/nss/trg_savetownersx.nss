#include "nw_i0_tool"
void main()
{

object oPC = GetPCSpeaker();
RewardPartyXP(200, oPC, TRUE);
AdjustAlignment(oPC, ALIGNMENT_LAWFUL, 1);

ClearAllActions();
ActionJumpToObject(GetObjectByTag("PLC_DEATHJUMP"));

}
