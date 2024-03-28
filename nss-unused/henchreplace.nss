#include "hench_i0_henlvl"

int StartingConditional()
{
    float fAuldarVersion = GetLocalFloat(OBJECT_SELF,"AuldarVersion");
    ExecuteScript("henchauldar",OBJECT_SELF);
// Auldar: Modified so if the henchman can already levelup, the "upgrade" option does not show up.
    if (fAuldarVersion != GetLocalFloat(OBJECT_SELF,"AuldarVersion") && !(GetCanLevelUp(GetPCSpeaker())))
    {
        SetLocalFloat(OBJECT_SELF,"AuldarVersion",fAuldarVersion);
        return TRUE;
    }
    SetLocalFloat(OBJECT_SELF,"AuldarVersion",fAuldarVersion);
    return FALSE;
}
