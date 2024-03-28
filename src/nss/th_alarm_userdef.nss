//::///////////////////////////////////////////////
//:: On User Defined
//:: TH_ALARM_USERDEF
//:://////////////////////////////////////////////
/*
    Determines the course of action to be taken
    on a user defined event.
*/
//:://////////////////////////////////////////////
//:: Created By: Eugene Scully
//:: Created On: October 6, 2002
//:://////////////////////////////////////////////
#include "NW_I0_GENERIC"
#include "th_npc_include"

void    CallToArms(int iEventNum) {

    //SpeakString("Call to arms", TALKVOLUME_SHOUT);

    if (GetLocalInt(OBJECT_SELF, "bCheckAlive") == TRUE) {
        object oTriggerer = GetLocalObject(OBJECT_SELF, "oTriggerer");

        if (oTriggerer == OBJECT_INVALID)
            return;

        if ((GetIsDead(oTriggerer) == TRUE) || (GetIsAware(oTriggerer) == FALSE)) {
            //  Maybe should also check if a friend is nearby to raise alarm?
            //object oTriggerer = GetNearestObjectByTag(GetTag(oTriggerer), oTriggerer, 2);
            //if (oTriggerer == OBJECT_INVALID)
            //    return;
            //  This is no good, could be miles away...
            //if (GetIsInCombat(oTriggerer) == FALSE)
                return;
        }

        AssignCommand(oTriggerer, ActionSpeakString("NW_I_WAS_ATTACKED", TALKVOLUME_SILENT_TALK));
    }

    int     iObjectNum = 2;
    object  oReceiver = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_NOT_PC, OBJECT_SELF, 1);

    while (oReceiver != OBJECT_INVALID) {
        //  Grab each creature one by one & signal ...
        SetLocalInt(oReceiver, "bLocalEv", FALSE);
        SignalEvent(oReceiver, EventUserDefined(iEventNum));
        oReceiver = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_NOT_PC, OBJECT_SELF, iObjectNum);
        iObjectNum++;
    }

}

void    ResetEvents() {

    //SpeakString("Reset Events", TALKVOLUME_SHOUT);

    int     iObjectNum = 2;
    object  oReceiver = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_NOT_PC, OBJECT_SELF, 1);

    while (oReceiver != OBJECT_INVALID) {
        //  Grab each creature one by one & signal ...
        SetLocalInt(oReceiver, "bLocalEv", FALSE);
        SignalEvent(oReceiver, EventUserDefined(250));
        oReceiver = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_NOT_PC, OBJECT_SELF, iObjectNum);
        iObjectNum++;
    }

}

void main()
{

    int iEventNum = GetUserDefinedEventNumber();

    switch(iEventNum) {
    case 250:   //  Reset alarm events ...
        ResetEvents();
        break;
    case 251:   //  Alarm has been raised ...
    case 252:
    case 253:
    case 254:
        DelayCommand(GetLocalFloat(OBJECT_SELF, "fDelay"), CallToArms(iEventNum));
        break;
    default:
        break;
    }
}

