//#include "nw_i0_henchman"
//#include "69_i0_henchman"
#include "69_inc_henai"

void main()
{
    int nHench = GetLocalInt(GetPCSpeaker(), "nHench");
    SetFormerMaster(GetPCSpeaker(), OBJECT_SELF);
    object myMaster = GetMaster();
    SetLocalInt(GetPCSpeaker(), "nHench", nHench -1);
    RemoveHenchman(myMaster);
    object myHenchman = GetHenchman();
    if (GetIsObjectValid(myHenchman))
    {
        RemoveHenchman(OBJECT_SELF, myHenchman);
        AddHenchman(myMaster, myHenchman);
    }
    ClearAllActions();
}
