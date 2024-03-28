#include "inc_party"
#include "nw_i0_tool"
void main()
{

object oPC = GetPCSpeaker();
RewardPartyXP(2000, oPC, TRUE);
RewardPartyGP(5000, oPC, FALSE);
CreateItemOnObject("bovineplate", oPC);
SetPartyInt(oPC, "cowmantalk2", 1);

}

