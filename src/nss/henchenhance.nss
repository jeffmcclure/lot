#include "hench_i0_enhanc"

void main()
{
    ActionPauseConversation();
    if (HenchTalentSummonAllies()) return;
    int iBuffed = HenchTalentUseProtectionOthers(GetPCSpeaker());
    if (!iBuffed) iBuffed = HenchTalentEnhanceOthers(GetPCSpeaker(),TRUE);
    SetLocalInt(GetPCSpeaker(),"BuffedUp",iBuffed);
    ActionResumeConversation();
}
