#include "nw_i0_tool"
void main()
{

object oPC = GetPCSpeaker();

object oTarget;
oTarget = GetObjectByTag("D1_UNDEADCROWN");
DestroyObject(oTarget, 0.0);
RewardPartyGP(1000, oPC, TRUE);

}
