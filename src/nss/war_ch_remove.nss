#include "nw_i0_henchman"

void main()
{
    object oPC = GetPCSpeaker();
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
    //ClearAllActions();
    object oTarget;
    oTarget = GetObjectByTag("JARULF");
    AssignCommand(oTarget, ActionMoveAwayFromObject(oPC));
    AssignCommand(oTarget, ActionWait(3.0f));
    AssignCommand(oTarget, ActionJumpToObject(GetObjectByTag("POST_JARULF")));
    //ClearAllActions();

}
