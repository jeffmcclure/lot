// Simple way to add an NPC to the "Old Acquaintances..." quest.  See con_cow.dlg.json5
#include "inc_party"
#include "nw_i0_tool"
#include "inc_oldacquainta"
int StartingConditional() {
    object oPC=GetPCSpeaker();

    // OBJECT_SELF is the NPC we are talking to
    string sTag=GetTag(OBJECT_SELF);

    if (GetPartyInt(oPC, sTag) == 1) return 1; // ensure we only process this once

    SetPartyInt(oPC, sTag, 1);
    RewardPartyXP(250, oPC, TRUE);
    OldAcquaintance(OBJECT_SELF);
    return 1;
}
