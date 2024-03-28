//PUT THIS ON ACTION TAKEN OF THE SAME LINE
#include "inc_party"
#include "nw_i0_tool"
void main()
{
object oPC=GetPCSpeaker();
string sTag=GetTag(OBJECT_SELF);

SetPartyInt(oPC, sTag, 1);
RewardPartyXP(250, oPC, TRUE);

}

