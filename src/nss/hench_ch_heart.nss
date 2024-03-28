//:://////////////////////////////////////////////////
//:: X0_CH_HEN_HEART
/*

  OnHeartbeat event handler for henchmen/associates.

 */
//:://////////////////////////////////////////////////
//:: Copyright (c) 2002 Floodgate Entertainment
//:: Created By: Naomi Novik
//:: Created On: 01/05/2003
//:://////////////////////////////////////////////////
#include "X0_INC_HENAI"
#include "hench_i0_generic"



void main()
{
//    Jug_Debug("*****" + GetName(OBJECT_SELF) + " heartbeat " + IntToString(GetCurrentAction()) + " busy " + IntToString(GetAssociateState(NW_ASC_IS_BUSY)));

    // If the henchman is in dying mode, make sure
    // they are non commandable. Sometimes they seem to
    // 'slip' out of this mode
    int bDying = GetIsHenchmanDying();

    if (bDying)
    {
        int bCommandable = GetCommandable();
        if (bCommandable == TRUE)
        {
            // lie down again
            ActionPlayAnimation(ANIMATION_LOOPING_DEAD_FRONT,
                                          1.0, 65.0);
           SetCommandable(FALSE);
        }
    }

    // If we're dying or busy, we return
    // (without sending the user-defined event)
    if(GetAssociateState(NW_ASC_IS_BUSY) || bDying)
    {
        return;
    }

    ExecuteScript("nw_ch_ac1", OBJECT_SELF);
}



