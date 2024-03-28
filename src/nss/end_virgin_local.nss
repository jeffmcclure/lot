//PUT THIS ON ACTION TAKEN OF THE SAME LINE
#include "inc_party"
#include "nw_i0_tool"
void main() {
    object oPC=GetPCSpeaker();

    // OBJECT_SELF is the NPC we are talking to
    string sTag=GetTag(OBJECT_SELF);

    SetLocalInt(oPC, sTag, 1);
    RewardPartyXP(250, oPC, FALSE);
}
