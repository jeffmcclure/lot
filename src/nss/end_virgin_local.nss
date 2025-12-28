//PUT THIS ON ACTION TAKEN OF THE SAME LINE
#include "inc_party"
#include "nw_i0_tool"
#include "inc_oldacquainta"
void main() {
    object oPC=GetPCSpeaker();

    // OBJECT_SELF is the NPC we are talking to; GetTag() returns "NPC_THEEMON" for example
    string sTag=GetTag(OBJECT_SELF);

    if (GetLocalInt(oPC, sTag) == 1) return; // ensure we only process this once

    SetLocalInt(oPC, sTag, 1);
    RewardPartyXP(250, oPC, FALSE);
    OldAcquaintance(OBJECT_SELF);
}
