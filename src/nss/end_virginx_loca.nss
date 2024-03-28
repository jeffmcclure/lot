//PUT THIS ON ACTION TAKEN OF THE SAME LINE
#include "inc_party"
#include "nw_i0_tool"
#include "inc_oldacquainta"
void main() {
    object oPC=GetPCSpeaker();

    string sTag=GetTag(OBJECT_SELF); // OBJECT_SELF is the NPC we are talking to; GetTag() returns "NPC_THEEMON" for example

    SetLocalInt(oPC, sTag, 1);
    //RewardPartyXP(250, oPC, TRUE);
    OldAcquaintance(oPC, sTag);
}
