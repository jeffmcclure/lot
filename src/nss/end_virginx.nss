//PUT THIS ON ACTION TAKEN OF THE SAME LINE
#include "inc_party"
#include "nw_i0_tool"
#include "inc_oldacquainta"
void main() {
    object oPC=GetPCSpeaker();

    // OBJECT_SELF is the NPC we are talking to
    string sTag=GetTag(OBJECT_SELF);

    if (GetPartyInt(oPC, sTag) == 1) return; // ensure we only process this once

    SetPartyInt(oPC, sTag, 1);
    //RewardPartyXP(250, oPC, TRUE);
    OldAcquaintance(OBJECT_SELF);
}
