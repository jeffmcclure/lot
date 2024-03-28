#include "nw_i0_tool"
void main()
{

object oPC = GetPCSpeaker();
RewardPartyXP(200, oPC, TRUE);
AdjustAlignment(oPC, ALIGNMENT_LAWFUL, 1);

object oTarget;
oTarget = OBJECT_SELF;

DestroyObject(oTarget, 0.0);

}
