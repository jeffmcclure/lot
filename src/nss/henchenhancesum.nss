#include "hench_i0_enhanc"

void main()
{
    object oAss = GetAssociate(ASSOCIATE_TYPE_SUMMONED,GetPCSpeaker());
    int iBuffed = HenchTalentUseProtectionOthers(oAss);
    if (!iBuffed) iBuffed = HenchTalentEnhanceOthers(oAss,TRUE);
    SetLocalInt(GetPCSpeaker(),"BuffedUp",iBuffed);
}
