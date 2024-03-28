#include "nw_i0_tool"
void main()
{

object oPC = GetPCSpeaker();

object oTarget;
oTarget = GetObjectByTag("D1_BUTCHERSCLEAVER");
DestroyObject(oTarget, 0.0);
RewardPartyGP(5000, oPC, FALSE);
AdjustAlignment(oPC, ALIGNMENT_CHAOTIC, 2);

}
