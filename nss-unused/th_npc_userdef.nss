//::///////////////////////////////////////////////
//:: Default: On User Defined
//:: TH_NPC_USERDEF
//:://////////////////////////////////////////////
/*
    Determines the course of action to be taken
    on a user defined event.
*/
//:://////////////////////////////////////////////
//:: Created By: Eugene Scully (for www.ardan-nights.org)
//:: Created On: July 1, 2002
//:: Updated On: November 22, 2002 (Version 3.2)
//:://////////////////////////////////////////////

#include "NW_I0_GENERIC"
#include "th_npc_include"

void main()
{
    int iUserDefEvent = GetUserDefinedEventNumber();

    switch(iUserDefEvent) {
    case 201:       //  Another NPC is talking to me !
        //  We should pause current action here for the moment & resume later ...
        {
        //SpeakString("Talking to : " + GetLocalString(OBJECT_SELF, "sTalkToNPC"));
        object oNPC = GetNearestObjectByTag(GetLocalString(OBJECT_SELF, "sTalkToNPC"));
        if (oNPC != OBJECT_INVALID) {
            SetFacing(GetFacingOpposite(oNPC));
        }
        ActionSpeakGreetingPhrase(GetLocalInt(OBJECT_SELF, "TalkVolume"));
        SetLocalInt(OBJECT_SELF, "iIsTalking", 1);
        }
        break;
    case 202:       //  Another NPC has finished talking to me !
       {
        int iTalkVolume = GetLocalInt(OBJECT_SELF, "TalkVolume");
        ActionSpeakFarewellPhrase(iTalkVolume);
        SetLocalInt(OBJECT_SELF, "iIsTalking", 0);
        }
        break;
    case 222: {     //  Someone is opening one of my belongings (Anti-theft script)
        if ((GetIsObjectValid(GetAttemptedAttackTarget())) ||
            (GetIsObjectValid(GetAttemptedSpellTarget())) ||
            (GetIsAware() == FALSE))
            return;     //  If in battle (or asleep) I should ignore the thief.
        object oDisturber = GetLocalObject(OBJECT_SELF, "oDisturber");
        if (GetIsReactionTypeHostile(oDisturber))
            return;     //  If already hostile also return.
        if ((oDisturber != OBJECT_INVALID) && (GetIsPC(oDisturber))) {
            if (GetObjectSeen(oDisturber) || GetObjectHeard(oDisturber)) {
                ClearAllActions();
                if (GetIsInCombat(oDisturber)) {
                    //  Problem won't start conversation if in combat ... I can only speak one line!
                    SpeakOneLinerConversation(GetLocalString(OBJECT_SELF, "sNpcThief"));
                }
                else
                    ActionStartConversation(oDisturber, GetLocalString(OBJECT_SELF, "sNpcThief"));
            }
        }
        break;
    }
    case 250:       //  Reset all event triggers ...
        SetLocalInt(OBJECT_SELF, "iEvent", 0);
        SetLocalInt(OBJECT_SELF, "CurrentWaypoint", GetLocalInt(OBJECT_SELF, "iPreEventWp"));
        break;
    case 251:
    case 252:
    case 253:
    case 254:
    {
        int iEventNum = iUserDefEvent - 250;
        //SpeakString("Event trigger " + IntToString(iEventNum));
        if ((GetLocalInt(OBJECT_SELF, "bEvent" + IntToString(iEventNum)) == FALSE) || (GetIsAware() == FALSE))
            return;
        //  If in combat/conversation ignore the event??
        if ((!GetIsObjectValid(GetAttemptedAttackTarget())) &&
                (!GetIsObjectValid(GetAttemptedSpellTarget())) &&
                (!IsInConversation(OBJECT_SELF))) {
            ClearAllActions();
            SetLocalInt(OBJECT_SELF, "iContinuedAction", 0);
            SetLocalInt(OBJECT_SELF, "bIsBusy", FALSE);
            if (GetLocalInt(OBJECT_SELF, "iEvent") == 0) // Save current task
                SetLocalInt(OBJECT_SELF, "iPreEventWp", GetLocalInt(OBJECT_SELF, "iLastWp"));
            SetLocalInt(OBJECT_SELF, "iEvent", iEventNum);
            SetLocalInt(OBJECT_SELF, "CurrentWaypoint", 0);     //  Reset current waypoint ??? Wait we should save the last waypoint
        }
        break;
    }
    case 1001:      //  Heartbeat
        //  Are there any PCs in the area??
        //if (GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC) == OBJECT_INVALID)
        if (GetHasEffect(EFFECT_TYPE_SLEEP)) {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_SLEEP), OBJECT_SELF);
        }
        else if (
                (GetIsObjectValid(GetAttemptedAttackTarget())) ||
                (GetIsReactionTypeHostile(GetAttemptedSpellTarget())) ||
                (((IsInConversation(OBJECT_SELF)) && (GetLocalInt(OBJECT_SELF, "bIsBusy") != NPC_COMMAND_CONVERSATION)))
                ) {
                    //  If in battle or conversation ... reset to prev task
                    SetLocalInt(OBJECT_SELF, "CurrentWaypoint", GetLocalInt(OBJECT_SELF, "iLastWp"));
        }
        else if ((!GetIsObjectValid(GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN))) &&
                (!GetBehaviorState(NW_FLAG_BEHAVIOR_SPECIAL)))
            ActionDoTasks();
        break;
    case 1002:  //  Perceive event
        //  Execute script defined by SetPerceiveScript() function.
        ExecuteScript(GetLocalString(OBJECT_SELF, "sPerc"), OBJECT_SELF);
        break;
    }

    return;

}


