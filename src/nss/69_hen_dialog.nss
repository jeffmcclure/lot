//::///////////////////////////////////////////////
//:: Associate: On Dialogue
//:: 69_hen_dialog
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Determines the course of action to be taken
    by the generic script after dialogue or a
    shout is initiated.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 24, 2001
//:://////////////////////////////////////////////

#include "69_inc_henai"

int AbleToTalk(object oSelf)
{
    if (GetCommandable(oSelf) == FALSE)
    {
        if (GetHasEffect(EFFECT_TYPE_CONFUSED, oSelf) || GetHasEffect(EFFECT_TYPE_DOMINATED, oSelf) ||
            GetHasEffect(EFFECT_TYPE_PETRIFY, oSelf) || GetHasEffect(EFFECT_TYPE_PARALYZE, oSelf)   ||
            GetHasEffect(EFFECT_TYPE_STUNNED, oSelf) || GetHasEffect(EFFECT_TYPE_FRIGHTENED, oSelf)
        )
        {
            return FALSE;
        }
    }
    return TRUE;
}

void main()
{
    if (GetIsHenchmanDying() == TRUE)
    {
        return;
    }
    object oShouter = GetLastSpeaker();
    object oMaster = GetMaster();
    int nMatch = GetListenPatternNumber();

    object oIntruder;

    if (nMatch == -1)
    {
        if(AbleToTalk(OBJECT_SELF) && (GetCurrentAction() != ACTION_OPENLOCK))
        {   SetCommandable(TRUE);
            ClearAllActions();
            BeginConversation();
        }
    } else {
        // listening pattern matched
        if (GetIsObjectValid(oMaster)) {
            // we have a master, only listen to them
            if (GetIsObjectValid(oShouter) && oMaster == oShouter) {
                SetCommandable(TRUE);
                bkRespondToHenchmenShout(oShouter, nMatch, oIntruder);
            }
        }

        // we don't have a master, behave in default way
        else if (GetIsObjectValid(oShouter)
                 && !GetIsPC(oShouter)
                 && GetIsFriend(oShouter)) {

             object oIntruder = OBJECT_INVALID;

             // Determine the intruder if any
             if(nMatch == 4) {
                 oIntruder = GetLocalObject(oShouter, "NW_BLOCKER_INTRUDER");
             }
             else if (nMatch == 5) {
                 oIntruder = GetLastHostileActor(oShouter);
                 if(!GetIsObjectValid(oIntruder)) {
                     oIntruder = GetAttemptedAttackTarget();
                     if(!GetIsObjectValid(oIntruder)) {
                         oIntruder = GetAttemptedSpellTarget();
                     }
                 }
             }

             // Actually respond to the shout
             RespondToShout(oShouter, nMatch, oIntruder);
         }
    }
    // Signal user-defined event
    if(GetSpawnInCondition(NW_FLAG_ON_DIALOGUE_EVENT))
    {
        SignalEvent(OBJECT_SELF, EventUserDefined(EVENT_DIALOGUE));
    }

}

