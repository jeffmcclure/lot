//::///////////////////////////////////////////////
//:: Associate On Attacked
//:: 69_hen_attacked
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    If already fighting then ignore, else determine
    combat round
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 16, 2001
//:://////////////////////////////////////////////

#include "69_inc_henai"

void main()
{
    SpeakString("NW_I_WAS_ATTACKED", TALKVOLUME_SILENT_TALK);
    if(!GetAssociateState(NW_ASC_IS_BUSY) && GetLocalInt(OBJECT_SELF, MH_MODE_ATTACK))
    {
        SetCommandable(TRUE);
        if(!GetAssociateState(NW_ASC_MODE_STAND_GROUND))
        {
            if(!GetIsObjectValid(GetAttackTarget()) && !GetIsObjectValid(GetAttemptedSpellTarget()))
            {
                if(GetIsObjectValid(GetLastAttacker()))
                {
                    if(GetAssociateState(NW_ASC_MODE_DEFEND_MASTER))
                    {
                        if(!GetIsObjectValid(GetLastAttacker(GetRealMaster())))
                        {
                            DetermineCombatRound();
                        }
                    }
                    else
                    {
                        DetermineCombatRound();
                    }

                }
            }
            if(GetLocalInt(OBJECT_SELF,"Scouting"))
            {
             SetLocalInt(OBJECT_SELF, "Scouting", FALSE);
            }
            if(GetSpawnInCondition(NW_FLAG_ATTACK_EVENT))
            {
                SignalEvent(OBJECT_SELF, EventUserDefined(1005));
            }
        }
    }
}

