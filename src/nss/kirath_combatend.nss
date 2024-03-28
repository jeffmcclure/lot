//::///////////////////////////////////////////////
//:: Associate: End of Combat End
//:: NW_CH_AC3
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Calls the end of combat script every round
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 16, 2001
//:://////////////////////////////////////////////
#include "x0_inc_henai"

void main()
{
    if(!GetSpawnInCondition(NW_FLAG_SET_WARNINGS))
    {
       HenchmenCombatRound(OBJECT_INVALID);
    }



    if(GetSpawnInCondition(NW_FLAG_END_COMBAT_ROUND_EVENT))
    {
        SignalEvent(OBJECT_SELF, EventUserDefined(1003));
    }

    //object ocontroldeathblock = GetObjectByTag("controldeathblock");

    //if (GetLocalInt(ocontroldeathblock, "SetIsDestroyable is set for Kirath, TRUE, TRUE, TRUE") == 0)
    //{
    //SetIsDestroyable(TRUE, TRUE, TRUE);
    //DelayCommand(0.1, SetLootable(OBJECT_SELF, TRUE));
    //SetLocalInt(ocontroldeathblock, "SetIsDestroyable is set for Kirath, TRUE, TRUE, TRUE", 1);
    //}
}
