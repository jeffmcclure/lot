#include "69_i0_henchman"

void main()
{
    int nHench = GetLocalInt(GetPCSpeaker(), "nHench");

    SetFormerMaster(GetPCSpeaker(), OBJECT_SELF);
    RemoveHenchman(GetPCSpeaker());
    SetLocalInt(GetPCSpeaker(), "nHench", nHench -1);
    ClearAllActions();

}
