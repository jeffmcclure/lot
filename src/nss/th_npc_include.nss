//::///////////////////////////////////////////////
//:: Default: Include file
//:: TH_NPC_INCLUDE
//:://////////////////////////////////////////////
/*
    //  This contains all the functions/defines/structs required
    //  for my generic NPC scripts...
*/
//:://////////////////////////////////////////////
//:: Created By: Eugene Scully (for www.ardan-nights.org)
//:: Created On: July 1, 2002
//:: Updated On: November 22, 2002 (Version 3.2)
//:://////////////////////////////////////////////

//  Uncomment this to compile as a normal script ...
//int StartingConditional() {
//    return 0;
//}

//  Local used variable name list
//  "bStartTimer"       - Duration timer has started
//  "iTimerVal"         - Timer start time seconds
//  "iTimerValMin"      - Timer start time minutes
//  "fTimerDuration"    - Timer duration
//  "iContinuedAction"  - Action is continued action

struct sNpcTask {
    object  oWaypoint;          //  Object/waypoint/NPC of task
    int     associatedCommand;  //  Command NPC_COMMAND_...
    int     dayNight;           //  Time of task NPC_TIME_...
    float   fDuration;          //  Duration of task
    int     bRunToPoint;        //  Run to the location
};

int NPC_STATE_BUSY = 1;
int NPC_STATE_WAITCOMMAND = 2;

int NPC_COMMAND_INVALID = 0;
int NPC_COMMAND_SLEEP = 1;          //  Requires object/waypoint
int NPC_COMMAND_TALKNORMAL = 2;     //  Requires NPC
int NPC_COMMAND_SIT = 3;            //  Requires chair/stool
int NPC_COMMAND_OBSERVE = 4;        //  Requires object/waypoint
int NPC_COMMAND_USEOBJECTMED = 5;   //  Requires object/waypoint
int NPC_COMMAND_WAIT = 6;           //  Requires object/waypoint
int NPC_COMMAND_DRINK = 7;          //  Requires object/waypoint
int NPC_COMMAND_READ = 8;           //  Requires object/waypoint
//int NPC_COMMAND_STEAL = 9;        //  Requires waypoint
int NPC_COMMAND_WORSHIP = 10;       //  Requires object/waypoint
int NPC_COMMAND_USEOBJECTLOW = 11;  //  Requires object/waypoint
int NPC_COMMAND_TALKSALUTE = 12;
int NPC_COMMAND_SITCROSS = 13;      //  Requires object/waypoint
int NPC_COMMAND_TALKWHISPER = 14;   //  Requires NPC
int NPC_COMMAND_TALKSHOUT = 15;     //  Requires NPC
int NPC_COMMAND_JUMPTOLOCATION = 16;//  Requires object/waypoint/NPC
int NPC_COMMAND_CLOSELOCK = 17;     //  Requires door or lockable object
int NPC_COMMAND_UNLOCK = 18;        //  Requires lockable object
int NPC_COMMAND_LOOKFAR = 19;       //  Requires object/waypoint
int NPC_COMMAND_OPENCLOSE = 20;     //  Requires object with open/close animation
int NPC_COMMAND_RANDOMWALK = 21;    //  Requires object/waypoint/NPC
int NPC_COMMAND_CHANGECLOTHES = 22; //  Requires the tag of the clothes to be changed into. They must be in the NPC's inventory!
int NPC_COMMAND_ANNOUNCE = 23;      //  Requires object/waypoint/NPC
//int NPC_COMMAND_ATTACK = 24;      //  Requires a placeable object (best if it is a plot object)
int NPC_COMMAND_EXECUTESCRIPT1 = 25;//  Requires object/waypoint/NPC. Script name must be set using SetExecutableScript1.
int NPC_COMMAND_EXECUTESCRIPT2 = 26;//  Requires object/waypoint/NPC. Script name must be set using SetExecutableScript2.
int NPC_COMMAND_DESTROYOBJECT = 27; //  Requires object/waypoint/NPC (This is a feature request - can be used to destroy the calling NPC)
int NPC_COMMAND_PLAYSOUND = 28;     //  Requires object/waypoint/NPC.
int NPC_COMMAND_CONVERSATION = 29;  //  Requires PC target. Conversation file set using SetConversation()
//  Events & command which the nPC is not required to move
int NPC_COMMAND_RESETEVENT = 30;    //  No object required. Tells the NPC to return to normal (no events) mode
int NPC_COMMAND_ENABLEEVENT1 = 31;  //  No object required.
int NPC_COMMAND_DISABLEEVENT1 = 32; //  No object required.
int NPC_COMMAND_ENABLEEVENT2 = 33;  //  No object required.
int NPC_COMMAND_DISABLEEVENT2 = 34; //  No object required.
int NPC_COMMAND_ENABLEEVENT3 = 35;  //  No object required.
int NPC_COMMAND_DISABLEEVENT3 = 36; //  No object required.
int NPC_COMMAND_ENABLEEVENT4 = 37;  //  No object required.
int NPC_COMMAND_DISABLEEVENT4 = 38; //  No object required.
int NPC_COMMAND_RESETAREAEVENT = 39;//  No object required. Resets the events of all NPCs in an area (Warning very powerful)
int NPC_COMMAND_TRIGAREAEVENT1 = 40;//  Requires object/waypoint/NPC. Will trigger an area event
int NPC_COMMAND_TRIGAREAEVENT2 = 41;//  Requires object/waypoint/NPC. Will trigger an area event
int NPC_COMMAND_TRIGAREAEVENT3 = 42;//  Requires object/waypoint/NPC. Will trigger an area event
int NPC_COMMAND_TRIGAREAEVENT4 = 43;//  Requires object/waypoint/NPC. Will trigger an area event
int NPC_COMMAND_TRIGLOCEVENT1 = 44; //  Requires NPC of event to trigger. Will trigger an event on the NPC.
int NPC_COMMAND_TRIGLOCEVENT2 = 45; //  Requires NPC of event to trigger. Will trigger an event on the NPC.
int NPC_COMMAND_TRIGLOCEVENT3 = 46; //  Requires NPC of event to trigger. Will trigger an event on the NPC.
int NPC_COMMAND_TRIGLOCEVENT4 = 47; //  Requires NPC of event to trigger. Will trigger an event on the NPC.
//  Normal commands (no movement required)...
int NPC_COMMAND_SOUNDOBJMOVPLAY = 60;//  Requires Sound object. Moves a sound object to the NPCs location & plays it for the duration.
int NPC_COMMAND_SETFRIEND = 61;     //  Requires NPC
int NPC_COMMAND_SETNEUTRAL = 62;    //  Requires NPC
int NPC_COMMAND_SETENEMY = 63;      //  Requires NPC
int NPC_COMMAND_SETFACTION = 64;    //  Requires NPC/object of faction the NPC wants to join
//  Back to normal commands (move again - start at 80)...
int NPC_COMMAND_FASTWALK = 80;      //  NPC will walk to object/waypoint and do next task with no delay.
int NPC_COMMAND_MEDITATE = 81;      //  Requires object/waypoint
int NPC_COMMAND_DRUNK = 82;         //  Requires object/waypoint



//  There is no known way to get NPCs to set traps ATM (NWN v2.6)
//int NPC_COMMAND_SETTRAP = 30;       //  Requires Trap Skill.
//int NPC_COMMAND_REMOVETRAP = 31;    //  Requires Trap Skill.

//  Might implement these later ...
//int   NPC_COMMAND_GUARDOBJECT = 18;

int NPC_TIME_ALWAYS = 0;
int NPC_TIME_DAY = 1;
int NPC_TIME_NIGHT = 2;
int NPC_TIME_EXACTTIME = 3;
int NPC_TIME_WORKHOURS = 4;
int NPC_TIME_EVENTTRIGGERED1 = 5;
int NPC_TIME_EVENTTRIGGERED2 = 6;
int NPC_TIME_EVENTTRIGGERED3 = 7;
int NPC_TIME_EVENTTRIGGERED4 = 8;

int NPC_WPTYPE_CIRCULAR = 0;
int NPC_WPTYPE_RANDOM = 1;

//  These defines set the amount of processing done if there is no PC in the same area as the NPC.
int NPC_CPU_FULL = 0;
int NPC_CPU_DISABLEPATHFINDING = 1;
int NPC_CPU_NONE = 2;


//  Defines to remove reliance on nw_i0_generic
int NPC_FLAG_PERCIEVE_EVENT              = 0x00000200;

void NpcSetSpawnInCondition(int nCondition) {
    int nPlot = GetLocalInt(OBJECT_SELF, "NW_GENERIC_MASTER");
    nPlot = nPlot | nCondition;
    SetLocalInt(OBJECT_SELF, "NW_GENERIC_MASTER", nPlot);
}

float GetFacingOpposite(object oTarget) {
    float fFacingSource = GetFacing(oTarget);
    if (fFacingSource > 180.0) fFacingSource -= 180.0;
    else fFacingSource += 180.0;
    return(fFacingSource);
}

void RemoveAllTasks() {

   //SpeakString("RemoveAllWaypoints", TALKVOLUME_TALK);

//  Init all variables
    SetLocalInt(OBJECT_SELF, "NumWaypoints", 0);
    SetLocalInt(OBJECT_SELF, "CurrentWaypoint", 0);
    SetLocalInt(OBJECT_SELF, "iContinuedAction", 0);
    SetLocalInt(OBJECT_SELF, "iNumChores", 0);
    SetLocalInt(OBJECT_SELF, "bIsBusy", FALSE);
}

void SetWorkHours(int iStart, int iStop) {

    if (iStart == iStop)
        return;

    SetLocalInt(OBJECT_SELF, "iStartWork", iStart);
    SetLocalInt(OBJECT_SELF, "iStopWork", iStop);
}

void SetNPCProcessingLevel(int iValue) {

    SetLocalInt(OBJECT_SELF, "iCPU", iValue);
}

void SetPerceiveScript(string sPerceiveScript) {

    //  Allow used defined perceive scripts
    NpcSetSpawnInCondition(NPC_FLAG_PERCIEVE_EVENT);

    SetLocalString(OBJECT_SELF, "sPerc", sPerceiveScript);
}

int IsWorkHours() {

    int iHour = GetTimeHour();

    if ((iHour >= GetLocalInt(OBJECT_SELF, "iStartWork")) &&
        (iHour < GetLocalInt(OBJECT_SELF, "iStopWork")))
        return TRUE;
    else
        return FALSE;
}

void SetTaskOrder(int iOrder) {

    SetLocalInt(OBJECT_SELF, "WpType", iOrder);
}

void AddTask(struct sNpcTask inputWaypoint, int iStartHour = 25, int iStartMinute = 0) {

    //SpeakString("AddWaypoint", TALKVOLUME_TALK);

    int NumWaypoints = GetLocalInt(OBJECT_SELF, "NumWaypoints");

    string sVarName;
    string sWaypointNum;

    sWaypointNum = IntToString(NumWaypoints);
    //SpeakString(sWaypointNum, TALKVOLUME_TALK);

    sVarName = "NPC_WP_" + sWaypointNum;
    SetLocalObject(OBJECT_SELF, sVarName, inputWaypoint.oWaypoint);

    sVarName = "NPC_COMM_" + sWaypointNum;
    SetLocalInt(OBJECT_SELF, sVarName, inputWaypoint.associatedCommand);

    sVarName = "NPC_DAYN_" + sWaypointNum;
    SetLocalInt(OBJECT_SELF, sVarName, inputWaypoint.dayNight);

    //sVarName = "NPC_PERC_" + sWaypointNum;
    //SetLocalInt(OBJECT_SELF, sVarName, inputWaypoint.percentChance);

    sVarName = "NPC_DURA_" + sWaypointNum;
    SetLocalFloat(OBJECT_SELF, sVarName, inputWaypoint.fDuration);

    sVarName = "NPC_BRUN_" + sWaypointNum;
    SetLocalInt(OBJECT_SELF, sVarName, inputWaypoint.bRunToPoint);

    if (iStartHour < 24) {
        //  This is a daily chore
        int NumChores = GetLocalInt(OBJECT_SELF, "iNumChores");
        string sNumChores = IntToString(NumChores);

        sVarName = "NPC_CHORETIME_" + sNumChores;
        SetLocalInt(OBJECT_SELF, sVarName, iStartHour);

        sVarName = "NPC_CHOREMIN_" + sNumChores;
        SetLocalInt(OBJECT_SELF, sVarName, iStartMinute);

        sVarName = "NPC_CHORENUM_" + sNumChores;
        SetLocalInt(OBJECT_SELF, sVarName, NumWaypoints);

        NumChores++;
        SetLocalInt(OBJECT_SELF, "iNumChores", NumChores);
    }

    NumWaypoints++;
    SetLocalInt(OBJECT_SELF, "NumWaypoints", NumWaypoints);

}

int GetTaskCommand() {

    //SpeakString("GetNextWaypoint", TALKVOLUME_TALK);

    int NumWaypoints = GetLocalInt(OBJECT_SELF, "NumWaypoints");
    int CurrentWaypoint = GetLocalInt(OBJECT_SELF, "CurrentWaypoint");

    if (NumWaypoints == 0) {
        return (NPC_COMMAND_INVALID);
    }

    string sVarName;

    sVarName = "NPC_COMM_" + IntToString(CurrentWaypoint);

    return (GetLocalInt(OBJECT_SELF, sVarName));
}

  //  Old function
int GetNextWaypoint(int iCurrent, int iNumWps, int iWpType) {

    int iNewWp;

    //SpeakString("Current WP " + IntToString(iCurrent));

    if (iWpType == NPC_WPTYPE_RANDOM) {
        iNewWp = Random(iNumWps);
        while (iNewWp == iCurrent)
            iNewWp = Random(iNumWps);
    }
    else {
        iNewWp = iCurrent + 1;
        if (iNewWp == iNumWps) {
            iNewWp = 0;
        }
    }
    //SpeakString("Next: " + IntToString(iNewWp));
    return iNewWp;
}

int GetNextLogicalWaypoint(int iCurrent, int iNumWps, int iWpType, int iDayNight) {

    int iNewWp;
    int iCount = 0;
    int dayNight = 0xff;
    string sVarName;

    //SpeakString("Get next logical WP");

    if (iNumWps < 2)
        return iCurrent;

    iNewWp = iCurrent;

    do {
        //  If not valid get another task
        //CurrentWaypoint = GetNextWaypoint(CurrentWaypoint, NumWaypoints, iWpType);
        if (iWpType == NPC_WPTYPE_RANDOM) {
            iNewWp = Random(iNumWps);
            while (iNewWp == iCurrent)
                iNewWp = Random(iNumWps);
        }
        else {
            iNewWp = iNewWp + 1;
            if (iNewWp == iNumWps) {
                iNewWp = 0;
            }
        }
        sVarName = "NPC_DAYN_" + IntToString(iNewWp);
        dayNight = GetLocalInt(OBJECT_SELF, sVarName);
        //SpeakString("wp: " + IntToString(dayNight) + " : " + IntToString(iNewWp) + " : " + IntToString(iDayNight));
        if (iCount++ > (iNumWps + iNumWps)) {
            SpeakString("No tasks found!");
            //    This is bad - no work tasks have been set - NPC just stands there
            return (-1);
        }
        if (dayNight == NPC_TIME_ALWAYS) {
            if ((iDayNight == NPC_TIME_DAY) || (iDayNight == NPC_TIME_NIGHT))
                break;  // Leave while loop
        }
    } while (dayNight != iDayNight);

    return iNewWp;
}

struct sNpcTask GetNextTask(int iNum = 255) {

    //SpeakString("GetNextTask", TALKVOLUME_TALK);

    struct sNpcTask returnWaypoint;

    int NumWaypoints = GetLocalInt(OBJECT_SELF, "NumWaypoints");
    int CurrentWaypoint;

    if (iNum == 255) {
        CurrentWaypoint = GetLocalInt(OBJECT_SELF, "CurrentWaypoint");
        //SpeakString("Getting Normal Task: " + IntToString(CurrentWaypoint));
    }
    else {
        //SpeakString("Getting Chore: " + IntToString(iNum));
        CurrentWaypoint = iNum;
    }

    if (NumWaypoints == 0) {
        //SpeakString("No waypoints set " + IntToString(CurrentWaypoint));
        returnWaypoint.associatedCommand = NPC_COMMAND_INVALID;
        return (returnWaypoint);
    }

    string sVarName;
    string sWaypointNum;

    sWaypointNum = IntToString(CurrentWaypoint);

    sVarName = "NPC_WP_" + sWaypointNum;
    returnWaypoint.oWaypoint = GetLocalObject(OBJECT_SELF, sVarName);

    sVarName = "NPC_COMM_" + sWaypointNum;
    returnWaypoint.associatedCommand = GetLocalInt(OBJECT_SELF, sVarName);

    sVarName = "NPC_DAYN_" + sWaypointNum;
    returnWaypoint.dayNight = GetLocalInt(OBJECT_SELF, sVarName);

    //sVarName = "NPC_PERC_" + sWaypointNum;
    //returnWaypoint.percentChance = GetLocalInt(OBJECT_SELF, sVarName);

    sVarName = "NPC_DURA_" + sWaypointNum;
    returnWaypoint.fDuration = GetLocalFloat(OBJECT_SELF, sVarName);

    sVarName = "NPC_BRUN_" + sWaypointNum;
    returnWaypoint.bRunToPoint = GetLocalInt(OBJECT_SELF, sVarName);

    //SpeakString("Task: " + IntToString(returnWaypoint.associatedCommand) + " Dur: " + FloatToString(returnWaypoint.fDuration));

    CurrentWaypoint = GetNextWaypoint(CurrentWaypoint, NumWaypoints, GetLocalInt(OBJECT_SELF, "WpType"));

    SetLocalInt(OBJECT_SELF, "CurrentWaypoint", CurrentWaypoint);

    //SpeakString("Exit get tasks:" + IntToString(CurrentWaypoint));

    return (returnWaypoint);
}

struct sNpcTask GetNextEventTask(int iEvent) {

    //SpeakString("GetNextEventTask " + IntToString(iEvent), TALKVOLUME_SHOUT);

    struct sNpcTask returnWaypoint;

    int iEventTimeConst;

    switch (iEvent) {
    case 1:
        iEventTimeConst = NPC_TIME_EVENTTRIGGERED1;
        break;
    case 2:
        iEventTimeConst = NPC_TIME_EVENTTRIGGERED2;
        break;
    case 3:
        iEventTimeConst = NPC_TIME_EVENTTRIGGERED3;
        break;
    case 4:
        iEventTimeConst = NPC_TIME_EVENTTRIGGERED4;
        break;
    default:
        iEventTimeConst = NPC_TIME_EVENTTRIGGERED1;
        break;
    }

    int NumWaypoints = GetLocalInt(OBJECT_SELF, "NumWaypoints");
    if (NumWaypoints == 0) {
        //SpeakString("No waypoints set " + IntToString(CurrentWaypoint));
        returnWaypoint.associatedCommand = NPC_COMMAND_INVALID;
        return (returnWaypoint);
    }

    int CurrentWaypoint = GetLocalInt(OBJECT_SELF, "CurrentWaypoint");
    SetLocalInt(OBJECT_SELF, "iLastWp", CurrentWaypoint);

    string sVarName;
    string sWaypointNum;
    int iDayNightElement;

    sVarName = "NPC_DAYN_" + IntToString(CurrentWaypoint);
    iDayNightElement = GetLocalInt(OBJECT_SELF, sVarName);

    //SpeakString("Check WP " + IntToString(CurrentWaypoint));
    //SpeakString("Check WP : " + IntToString(iEventTimeConst) + " = " + IntToString(iDayNightElement));

    if (iDayNightElement != iEventTimeConst) {
        CurrentWaypoint = GetNextLogicalWaypoint(CurrentWaypoint, NumWaypoints, NPC_WPTYPE_CIRCULAR, iEventTimeConst);
    }

    if (CurrentWaypoint == -1) {
        returnWaypoint.associatedCommand = NPC_COMMAND_INVALID;
        return (returnWaypoint);
    }

    sWaypointNum = IntToString(CurrentWaypoint);
    sVarName = "NPC_WP_" + sWaypointNum;
    returnWaypoint.oWaypoint = GetLocalObject(OBJECT_SELF, sVarName);
    if (returnWaypoint.oWaypoint == OBJECT_SELF) {
        //  This means use the alarm object ...
        if (GetLocalInt(OBJECT_SELF, "bLocalEv") == TRUE)
            returnWaypoint.oWaypoint = GetLocalObject(OBJECT_SELF, "oTarget");
        else
            returnWaypoint.oWaypoint = GetObjectByTag("th_alarm");
    }

    sVarName = "NPC_COMM_" + sWaypointNum;
    returnWaypoint.associatedCommand = GetLocalInt(OBJECT_SELF, sVarName);

    //sVarName = "NPC_DAYN_" + sWaypointNum;
    //returnWaypoint.dayNight = GetLocalInt(OBJECT_SELF, sVarName);

    sVarName = "NPC_DURA_" + sWaypointNum;
    returnWaypoint.fDuration = GetLocalFloat(OBJECT_SELF, sVarName);

    sVarName = "NPC_BRUN_" + sWaypointNum;
    returnWaypoint.bRunToPoint = GetLocalInt(OBJECT_SELF, sVarName);

    //SpeakString("Task: " + IntToString(returnWaypoint.associatedCommand) + " Dur: " + FloatToString(returnWaypoint.fDuration));

    //  Only allowed circular tasks during events...
    CurrentWaypoint = GetNextLogicalWaypoint(CurrentWaypoint, NumWaypoints, NPC_WPTYPE_CIRCULAR, iEventTimeConst);

    SetLocalInt(OBJECT_SELF, "CurrentWaypoint", CurrentWaypoint);

    //SpeakString("Exit get tasks:" + IntToString(CurrentWaypoint));

    return (returnWaypoint);
}

struct sNpcTask GetNextDayNightWorkTask(int dayNight) {

    //SpeakString("GetNextDayNightTask", TALKVOLUME_TALK);

    struct sNpcTask returnWaypoint;

    int NumWaypoints = GetLocalInt(OBJECT_SELF, "NumWaypoints");
    if (NumWaypoints == 0) {
        //SpeakString("No waypoints set " + IntToString(CurrentWaypoint));
        returnWaypoint.associatedCommand = NPC_COMMAND_INVALID;
        return (returnWaypoint);
    }

    int CurrentWaypoint = GetLocalInt(OBJECT_SELF, "CurrentWaypoint");
    SetLocalInt(OBJECT_SELF, "iLastWp", CurrentWaypoint);
    int iWpType = GetLocalInt(OBJECT_SELF, "WpType");

    //SpeakString("Check WP " + IntToString(CurrentWaypoint));

    string sVarName;
    string sWaypointNum;
    int iDayNightElement;

    sVarName = "NPC_DAYN_" + IntToString(CurrentWaypoint);
    iDayNightElement = GetLocalInt(OBJECT_SELF, sVarName);

    //SpeakString("Check WP : " + IntToString(iDayNightElement) + " = " + IntToString(dayNight));

    if (iDayNightElement != dayNight) {
        if (iDayNightElement == NPC_TIME_ALWAYS) {
            if ((dayNight != NPC_TIME_DAY) && (dayNight != NPC_TIME_NIGHT))
                CurrentWaypoint = GetNextLogicalWaypoint(CurrentWaypoint, NumWaypoints, iWpType, dayNight);
        }
        else
            CurrentWaypoint = GetNextLogicalWaypoint(CurrentWaypoint, NumWaypoints, iWpType, dayNight);
    }

    if (CurrentWaypoint == -1) {
        returnWaypoint.associatedCommand = NPC_COMMAND_INVALID;
        return (returnWaypoint);
    }

    sWaypointNum = IntToString(CurrentWaypoint);

    sVarName = "NPC_WP_" + sWaypointNum;
    returnWaypoint.oWaypoint = GetLocalObject(OBJECT_SELF, sVarName);

    sVarName = "NPC_COMM_" + sWaypointNum;
    returnWaypoint.associatedCommand = GetLocalInt(OBJECT_SELF, sVarName);

    //sVarName = "NPC_DAYN_" + sWaypointNum;
    //returnWaypoint.dayNight = GetLocalInt(OBJECT_SELF, sVarName);

    sVarName = "NPC_DURA_" + sWaypointNum;
    returnWaypoint.fDuration = GetLocalFloat(OBJECT_SELF, sVarName);

    sVarName = "NPC_BRUN_" + sWaypointNum;
    returnWaypoint.bRunToPoint = GetLocalInt(OBJECT_SELF, sVarName);

    //SpeakString("Task: " + IntToString(returnWaypoint.associatedCommand) + " Dur: " + FloatToString(returnWaypoint.fDuration));

    CurrentWaypoint = GetNextLogicalWaypoint(CurrentWaypoint, NumWaypoints, iWpType, dayNight);

    SetLocalInt(OBJECT_SELF, "CurrentWaypoint", CurrentWaypoint);

    //SpeakString("Exit get tasks:" + IntToString(CurrentWaypoint));

    return (returnWaypoint);
}

void SetGreetingPhrase(string sGreeting) {

    SetLocalString(OBJECT_SELF, "sNpcGreeting", sGreeting);
}

void SetFarewellPhrase(string sFarewell) {

    SetLocalString(OBJECT_SELF, "sNpcFarewell", sFarewell);
}

void SetAnnouncePhrase(string sGreeting) {

    SetLocalString(OBJECT_SELF, "sNpcAnnounce", sGreeting);
}

void SetThiefConversation(string sThief) {

    SetLocalString(OBJECT_SELF, "sNpcThief", sThief);
}

void SetConversation(string sConv) {

    SetLocalString(OBJECT_SELF, "sNpcConv", sConv);
}

void SetExecutableScript1(string sScriptName) {

    SetLocalString(OBJECT_SELF, "sNpcExecute1", sScriptName);
}

void SetExecutableScript2(string sScriptName) {

    SetLocalString(OBJECT_SELF, "sNpcExecute2", sScriptName);
}

void AddRandomPhrase(string sPhrase) {

    //  Get this working later ...
    int iNumPhrase = GetLocalInt(OBJECT_SELF, "iNpcNumPhrases");

    string sVarName = "NPC_RNDTALK_" + IntToString(iNumPhrase);

    SetLocalString(OBJECT_SELF, sVarName, sPhrase);

    iNumPhrase++;
    SetLocalInt(OBJECT_SELF, "iNpcNumPhrases", iNumPhrase);
}

void ClearPhrases() {

    SetLocalInt(OBJECT_SELF, "iNpcNumPhrases", 0);
}

void ActionSpeakRandomPhrase(int iTalkVolume) {

    float fRand = d100()/100.0 - 0.01;  //  Random number 0.00 to 0.99

    int iNumPhrase = GetLocalInt(OBJECT_SELF, "iNpcNumPhrases");

    int iPhrase = FloatToInt(IntToFloat(iNumPhrase) * fRand);

    string sVarName = "NPC_RNDTALK_" + IntToString(iPhrase);

    string sPhrase = GetLocalString(OBJECT_SELF, sVarName);

    if (sPhrase == "")
        return;

    if (GetStringLeft(sPhrase, 3) == "cv_") {
        ActionDoCommand(SpeakOneLinerConversation(sPhrase));
    }
    else
        ActionSpeakString(sPhrase, iTalkVolume);
}

void ActionSpeakGreetingPhrase(int iTalkVolume) {

    string sPhrase = GetLocalString(OBJECT_SELF, "sNpcGreeting");

    if (sPhrase == "")
        return;

    if (GetStringLeft(sPhrase, 3) == "cv_") {
        ActionDoCommand(SpeakOneLinerConversation(sPhrase));
    }
    else
        ActionSpeakString(sPhrase, iTalkVolume);
}

void ActionSpeakFarewellPhrase(int iTalkVolume) {

    string sPhrase = GetLocalString(OBJECT_SELF, "sNpcFarewell");

    if (sPhrase == "")
        return;

    if (GetStringLeft(sPhrase, 3) == "cv_") {
        ActionDoCommand(SpeakOneLinerConversation(sPhrase));
    }
    else
        ActionSpeakString(sPhrase, iTalkVolume);
}

void ActionSpeakAnnouncePhrase() {

    string sPhrase = GetLocalString(OBJECT_SELF, "sNpcAnnounce");

    if (sPhrase == "")
        return;

    if (GetStringLeft(sPhrase, 3) == "cv_") {
        ActionDoCommand(SpeakOneLinerConversation(sPhrase));
    }
    else
        ActionSpeakString(sPhrase);
}

string GetNPCSpeakerTag() {

    return (GetLocalString(OBJECT_SELF, "sTalkToNPC"));
}

void GuardContainer(string sContainerTag) {

    object oContainer = GetObjectByTag(sContainerTag);

    if (oContainer != OBJECT_INVALID) {
        SetLocalObject(oContainer, "oGuard", OBJECT_SELF);
    }

}

int     GetIsAware(object oTarget = OBJECT_SELF) {

    //  Maybe this will work equally as well ??
    //((GetAttemptedAttackTarget() == GetLastPerceived() ||
    //       GetAttemptedSpellTarget() == GetLastPerceived() ||
    //       GetAttackTarget() == GetLastPerceived()) && GetArea(GetLastPerceived()) != GetArea(OBJECT_SELF))
    //           return TRUE;

    //  Check if lower than 20% health
    /*
    int iHitPointDiff = (GetMaxHitPoints(oTarget) - GetCurrentHitPoints(oTarget));
    if (iHitPointDiff > 0) {
        if ((GetMaxHitPoints(oTarget)/iHitPointDiff) > 5) {
            return FALSE;
        }
    }
    */

    //  Check if has any incapacitating effects ...
    effect eCheck = GetFirstEffect(oTarget);
    int iEffectType;
    while (GetIsEffectValid(eCheck)) {
        iEffectType = GetEffectType(eCheck);
        if (iEffectType == EFFECT_TYPE_BLINDNESS)
             return FALSE;
        if (iEffectType == EFFECT_TYPE_CHARMED)
             return FALSE;
        if (iEffectType == EFFECT_TYPE_CONFUSED)
             return FALSE;
        if (iEffectType == EFFECT_TYPE_DAZED)
             return FALSE;
        if (iEffectType == EFFECT_TYPE_DOMINATED)
             return FALSE;
        if (iEffectType == EFFECT_TYPE_PARALYZE)
             return FALSE;
        if (iEffectType == EFFECT_TYPE_SILENCE)
             return FALSE;
        if (iEffectType == EFFECT_TYPE_SLEEP)
             return FALSE;
        if (iEffectType == EFFECT_TYPE_STUNNED)
             return FALSE;
        if (iEffectType == EFFECT_TYPE_TIMESTOP)
             return FALSE;
        if (iEffectType == EFFECT_TYPE_TURNED)
             return FALSE;
        eCheck = GetNextEffect(oTarget);
    }

    return TRUE;
}

//  iEventNum = 1 or 2
void    CreateAlarm(object oTarget, float fDelay, int bCheckTriggererAlive, int iAlarmNum = 1) {

    //SpeakString("CreateAlarm", TALKVOLUME_SHOUT);

    int iSeconds;
    object oAlarmPoint = GetNearestObjectByTag("th_alarm");

    if (oTarget == OBJECT_INVALID)
        return;

    if (oAlarmPoint != OBJECT_INVALID) {
        //SpeakString("DeleteAlarm", TALKVOLUME_SHOUT);
        iSeconds = GetTimeSecond() - GetLocalInt(oAlarmPoint, "iSecs");
        //  If the point moved recently, just return
        //  This will not be sucessful if exactly a minute passed!!
        if ((iSeconds > 0) && (iSeconds < 4))
            return;
        if (iSeconds < -56)
            return;
        DestroyObject(oAlarmPoint);
        //  Just incase there are extra alarm points left about!
        oAlarmPoint = GetNearestObjectByTag("th_alarm");
        if (oAlarmPoint != OBJECT_INVALID)
            DestroyObject(oAlarmPoint);
    }

    oAlarmPoint = CreateObject(OBJECT_TYPE_PLACEABLE, "th_alarm", GetLocation(oTarget));
    if (oAlarmPoint == OBJECT_INVALID) {
        SpeakString("Error: No th_alarm object placable exists.", TALKVOLUME_SHOUT);
        return;
    }

    iSeconds = GetTimeSecond();
    SetLocalInt(oAlarmPoint, "iSecs", iSeconds);
    SetLocalInt(oAlarmPoint, "bCheckAlive", bCheckTriggererAlive);
    SetLocalObject(oAlarmPoint, "oTriggerer", OBJECT_SELF);
    SetLocalObject(oAlarmPoint, "oTarget", oTarget);
    SetLocalFloat(oAlarmPoint, "fDelay", fDelay);

    if ((iAlarmNum > 0) && (iAlarmNum < 5))
        SignalEvent(oAlarmPoint, EventUserDefined(250 + iAlarmNum));
}

void    ClearAreaEvents() {

    object oAlarmPoint = GetNearestObjectByTag("th_alarm");

    if (oAlarmPoint != OBJECT_INVALID) {
        SignalEvent(oAlarmPoint, EventUserDefined(250));
    }

}


//  iEventNum = 1, 2, 3 or 4
void    TriggerNPCEvent(object oNPC, object oTarget, float fDelay, int iAlarmNum = 1) {

    //SpeakString("Trigger Event " + IntToString(iAlarmNum));

    if ((iAlarmNum < 1) || (iAlarmNum > 4))
        return;

    SetLocalObject(oNPC, "oTarget", oTarget);
    SetLocalInt(oNPC, "bLocalEv", TRUE);

    if ((oNPC == OBJECT_SELF) && (fDelay == 0.0)) {
        //SpeakString("Immediate Event");
        SetLocalInt(OBJECT_SELF, "iContinuedAction", 0);
        SetLocalInt(OBJECT_SELF, "bIsBusy", FALSE);
        //if (GetLocalInt(OBJECT_SELF, "iEvent") == 0) // Save current task
        //    SetLocalInt(OBJECT_SELF, "iPreEventWp", GetLocalInt(OBJECT_SELF, "iLastWp"));
        SetLocalInt(OBJECT_SELF, "iEvent", iAlarmNum);
        //  Should I reset this? Make grouping commands possible for circular tasks.
        SetLocalInt(OBJECT_SELF, "CurrentWaypoint", 0);     //  Reset current waypoint ??? Wait we should save the last waypoint
    }
    else
        SignalEvent(oNPC, EventUserDefined(250 + iAlarmNum));
}

void    ClearNPCEvent(object oNPC) {

    SetLocalInt(oNPC, "iEvent", 0);
    SetLocalInt(oNPC, "CurrentWaypoint", GetLocalInt(oNPC, "iPreEventWp"));

}

//  iEventNum = 1 or 2
void    SetEventResponse(int iEventNum, int bActive = TRUE) {

    switch (iEventNum) {
    case 1:
        SetLocalInt(OBJECT_SELF, "bEvent1", bActive);
        break;
    case 2:
        SetLocalInt(OBJECT_SELF, "bEvent2", bActive);
        break;
    case 3:
        SetLocalInt(OBJECT_SELF, "bEvent3", bActive);
        break;
    case 4:
        SetLocalInt(OBJECT_SELF, "bEvent4", bActive);
        break;
    default:
        break;
    }

}

object GetTransitionDoor(object oArea) {

    //  Find the correct door to transistion
    //  (could also be transition trigger!)
    int iCounter = 1;
    object oTarget;
    object oDoor = GetNearestObject(OBJECT_TYPE_DOOR, OBJECT_SELF, iCounter++);
    while (oDoor != OBJECT_INVALID) {
        //SpeakString("Check door: " + IntToString(iCounter) + ":" + GetTag(oDoor), TALKVOLUME_SHOUT);
        oTarget = GetTransitionTarget(oDoor);
        if ((oTarget != OBJECT_INVALID) && (GetArea(oTarget) == oArea)) {
            return (oDoor);
        }
        oDoor = GetNearestObject(OBJECT_TYPE_DOOR, OBJECT_SELF, iCounter++);
    }
    //  Now check for trigger transitions ...
    iCounter = 1;
    oDoor = GetNearestObject(OBJECT_TYPE_TRIGGER, OBJECT_SELF, iCounter++);
    while (oDoor != OBJECT_INVALID) {
        //SpeakString("Check trigger: " + IntToString(iCounter) + ":" + GetTag(oDoor), TALKVOLUME_SHOUT);
        oTarget = GetTransitionTarget(oDoor);
        if ((oTarget != OBJECT_INVALID) && (GetArea(oTarget) == oArea)) {
            //  We have the correct door
            return (oDoor);
        }
        oDoor = GetNearestObject(OBJECT_TYPE_TRIGGER, OBJECT_SELF, iCounter++);
    }
    //  No transition door found
    return (OBJECT_INVALID);
}

void ActionDoTasks(int bDelayed = FALSE) {

    //SpeakString("ActionDoTasks : " + IntToString(bDelayed), TALKVOLUME_TALK);
    int iChoreNum = -1;
    int iIsTalking;
    int iProcessingLevel = GetLocalInt(OBJECT_SELF, "iCPU");
    object oPCinArea = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC);
    int iEvent = GetLocalInt(OBJECT_SELF, "iEvent");

    if ((oPCinArea == OBJECT_INVALID) && (iProcessingLevel == NPC_CPU_NONE))
        return;

    int NumChores = GetLocalInt(OBJECT_SELF, "iNumChores");

    if ((iEvent == FALSE) && (bDelayed == FALSE)) {
        if ((NumChores > 0) && (NumChores < 11)) {
            if (GetTimeSecond() < 7) {
                //  New minute ticked over.
                string  sVarName;
                string  sChoreNum;
                int     i, iStartHour, iCurrHour, iCurrMin, iStartMin;
                //SpeakString("chore check");
                //  Check if chores need doing ...
                iCurrHour = GetTimeHour();
                iCurrMin = GetTimeMinute();
                for (i = 0; i < NumChores; i++) {
                    sChoreNum = IntToString(i);
                    sVarName = "NPC_CHORETIME_" + sChoreNum;
                    iStartHour = GetLocalInt(OBJECT_SELF, sVarName);
                    //SpeakString("Checking Chore: " + IntToString(iStartHour) + ":" + IntToString(iStartMin));
                    //SpeakString("Current time: " + IntToString(iCurrHour) + ":" + IntToString(iCurrMin));
                    if (iStartHour == iCurrHour) {
                        sVarName = "NPC_CHOREMIN_" + sChoreNum;
                        iStartMin = GetLocalInt(OBJECT_SELF, sVarName);
                        if (iStartMin == iCurrMin) {
                            sVarName = "NPC_CHORENUM_" + sChoreNum;
                            iChoreNum = GetLocalInt(OBJECT_SELF, sVarName);
                            break;
                        }
                    }
                }
                if (iChoreNum != -1) {
                    //SpeakString("Found Chore: " + IntToString(iCurrHour) + ":" + IntToString(iCurrMin));
                    SetLocalInt(OBJECT_SELF, "iChoreNumber", iChoreNum + 1);
                    ClearAllActions();
                    SetLocalInt(OBJECT_SELF, "iContinuedAction", 0);
                    SetLocalInt(OBJECT_SELF, "bIsBusy", FALSE);
                }
            }
            else {
                //  Check if last chore not completed ...
                iChoreNum = GetLocalInt(OBJECT_SELF, "iChoreNumber") - 1;
                /*
                if (iChoreNum != -1) {
                    //SpeakString("Chore not completed:" + IntToString(iChoreNum));
                    //ClearAllActions();
                    //SetLocalInt(OBJECT_SELF, "iContinuedAction", 0);
                    //SetLocalInt(OBJECT_SELF, "bIsBusy", FALSE);
                }
                */
            }
        }
    }

    iIsTalking = GetLocalInt(OBJECT_SELF, "iIsTalking");
    if (iIsTalking != 0) {
        if (iChoreNum == -1) {
            switch(iIsTalking) {
            case 1:     //  Talking (first call) ...
                {
                //SpeakString("Blah, blah...");
                ClearAllActions();
                ActionWait(0.5);
                object oNPC = GetNearestObjectByTag(GetNPCSpeakerTag());
                if (oNPC != OBJECT_INVALID) {
                    ActionDoCommand(SetFacing(GetFacingOpposite(oNPC)));
                }
                ActionPlayAnimation(ANIMATION_LOOPING_TALK_NORMAL, 1.0, 5.0);
                //  Restart current task upon finish talking.
                int iCurrWaypoint = GetLocalInt(OBJECT_SELF, "CurrentWaypoint");
                iCurrWaypoint--;
                if (iCurrWaypoint < 0) iCurrWaypoint = (GetLocalInt(OBJECT_SELF, "NumWaypoints") - 1);
                SetLocalInt(OBJECT_SELF, "CurrentWaypoint", iCurrWaypoint);
                SetLocalInt(OBJECT_SELF, "iIsTalking", 2);
                }
                return;
            case 2:     //  Still Talking (subsequent calls) ...
                ActionPlayAnimation(ANIMATION_LOOPING_TALK_NORMAL, 1.0, 5.0);
                //SpeakString("Rhubarb, Rhubarb...");
                return;
            }
        }
        else {
            //  Chore to be done ... stop talking please ...
            //SpeakString("Excuse me...");
            ActionSpeakFarewellPhrase(TALKVOLUME_TALK);
            SetLocalInt(OBJECT_SELF, "iIsTalking", 0);
            object oNPC = GetNearestObjectByTag(GetNPCSpeakerTag());
            if (oNPC != OBJECT_INVALID) {
                AssignCommand(oNPC, ClearAllActions());
                //  Should check if farewell string doesn't start with "cv_"
                //AssignCommand(oNPC, SpeakString(GetLocalString(oNPC, "sNpcFarewell")));
            }
        }
    }

    if ((bDelayed == FALSE) && (GetLocalInt(OBJECT_SELF, "bIsBusy") != FALSE)) {
        //SpeakString("Busy ...", TALKVOLUME_TALK);
        ActionDoCommand(SetLocalInt(OBJECT_SELF, "bIsBusy", FALSE));
        return;
    }

    int iAction = GetLocalInt(OBJECT_SELF, "iContinuedAction");

    struct sNpcTask npcWaypoint;

    if (iAction != 0) {
    //  A continued action ...
        //SpeakString("Continue action", TALKVOLUME_TALK);
        if (GetLocalInt(OBJECT_SELF, "bStartTimer") == FALSE) {
            //  Start the timer ...
            SetLocalInt(OBJECT_SELF, "bStartTimer", TRUE);
            SetLocalInt(OBJECT_SELF, "iTimerVal", GetTimeSecond());
            //SpeakString("Start Timer: " + IntToString(GetLocalInt(OBJECT_SELF, "iTimerValMin")) + ":" + IntToString(GetLocalInt(OBJECT_SELF, "iTimerVal")), TALKVOLUME_TALK);
            return;
        }
        // Check if action done ...
        //SpeakString("Time: " + IntToString(GetTimeHour()) + ":" + IntToString(GetTimeMinute()) + ":" + IntToString(GetTimeSecond()), TALKVOLUME_TALK);
        int iTimeDiff = GetTimeSecond() - GetLocalInt(OBJECT_SELF, "iTimerVal");
        if (iTimeDiff < 0) iTimeDiff += 60;
        //SpeakString("Time Left: " + IntToString(iTimeDiff) + "/" + FloatToString(GetLocalFloat(OBJECT_SELF, "fTimerDuration"), 5, 2), TALKVOLUME_TALK);
        if (iTimeDiff > FloatToInt(GetLocalFloat(OBJECT_SELF, "fTimerDuration"))) {
            //  Finished action ...
            SetLocalInt(OBJECT_SELF, "iContinuedAction", 0);
            iAction = 0;
        }
    }

    if (iAction == 0) {
        //  Not a continued action ...
        //SpeakString("Get next action", TALKVOLUME_TALK);

        if (!GetIsInCombat()) {
            //  Unequip all weapons
            if (GetItemInSlot(INVENTORY_SLOT_RIGHTHAND) != OBJECT_INVALID)
                ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND));
            if (GetItemInSlot(INVENTORY_SLOT_LEFTHAND) != OBJECT_INVALID)
                ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_LEFTHAND));
        }

        int iCount = 0;
        int iNumTasks = GetLocalInt(OBJECT_SELF, "NumWaypoints");
        if (iChoreNum == -1) {
            //  No chores atm
            if (iEvent != 0)           //  Event triggered
                npcWaypoint = GetNextEventTask(iEvent);
            else if (IsWorkHours() == TRUE) //  Work time
                npcWaypoint = GetNextDayNightWorkTask(NPC_TIME_WORKHOURS);
            else if (GetIsDay() == TRUE)    //  Day time
                npcWaypoint = GetNextDayNightWorkTask(NPC_TIME_DAY);
            else                            //  Night time
                npcWaypoint = GetNextDayNightWorkTask(NPC_TIME_NIGHT);
        }
        else {
            //SpeakString("Chore", TALKVOLUME_TALK);
            npcWaypoint = GetNextTask(iChoreNum);
        }

        //  We should store a location in the spawn script to speed this up ...
        if (!GetIsObjectValid(npcWaypoint.oWaypoint)) {
            //  Object has been destroyed/killed ...
            //SpeakString("Bad object !!", TALKVOLUME_TALK);
            return;
        }

        float     fDistance;   //   Distance to object

        iAction = npcWaypoint.associatedCommand;

        switch (iAction) {
        case 1:     //  Sleeping need to be closer ?
        case 13:    //  Sitting
            fDistance = 0.2; break;
        default:
            //fDistance = GetLocalFloat(OBJECT_SELF, "fDist");
            //if (fDistance <= 0.0)
            fDistance = 1.0;
            break;
        }

        SetLocalObject(OBJECT_SELF, "oNpcObject", npcWaypoint.oWaypoint);

        //SpeakString("(" + IntToString(GetTimeHour()) + ") Attempt to interact: " + GetTag(npcWaypoint.oWaypoint), TALKVOLUME_SHOUT);
        if (iAction == NPC_COMMAND_JUMPTOLOCATION) {
            //SetLocalInt(OBJECT_SELF, "iTransitionCount", 1);
            //SetLocalObject(OBJECT_SELF, "oTransLoc", npcWaypoint.oWaypoint);
            ActionJumpToObject(npcWaypoint.oWaypoint, FALSE);
            return;
        }
        else if ((iAction != NPC_COMMAND_CHANGECLOTHES) &&
            ((iAction < 30) || (iAction > 79))) {
            //ActionMoveToObject(npcWaypoint.oWaypoint, npcWaypoint.bRunToPoint, fDistance);
            if (GetArea(OBJECT_SELF) == GetArea(npcWaypoint.oWaypoint)) {
                //SpeakString("No Area transition", TALKVOLUME_SHOUT);
                //  Both the NPC & the object are in the same area .. no transitition required.
                if ((oPCinArea == OBJECT_INVALID) && (iProcessingLevel == NPC_CPU_DISABLEPATHFINDING)) {
                    int iPCNearCounter = GetLocalInt(OBJECT_SELF, "iPCNear");
                    if (iPCNearCounter <= 0) {
                        ActionJumpToObject(npcWaypoint.oWaypoint, FALSE);
                        ActionWait(5.0);
                    }
                    else {
                        SetLocalInt(OBJECT_SELF, "iPCNear", iPCNearCounter - 1);
                        ActionForceMoveToObject(npcWaypoint.oWaypoint, npcWaypoint.bRunToPoint, fDistance, 70.0);
                    }
                }
                else {  //  Normal movement to waypoint
                    ActionForceMoveToObject(npcWaypoint.oWaypoint, npcWaypoint.bRunToPoint, fDistance, 70.0);
                    SetLocalInt(OBJECT_SELF, "iPCNear", 2);
                }
            }
            else {  //  Area transition required
                //SpeakString("Area transition", TALKVOLUME_SHOUT);
                //  Is there a PC near the destination?
                object oPCinObjArea = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, npcWaypoint.oWaypoint);
                if ((oPCinArea != OBJECT_INVALID) && (oPCinObjArea != OBJECT_INVALID)) {
                    //SpeakString("PCs in both areas", TALKVOLUME_SHOUT);
                    ActionForceMoveToObject(npcWaypoint.oWaypoint, npcWaypoint.bRunToPoint, fDistance, 70.0);
                    SetLocalInt(OBJECT_SELF, "iPCNear", 2);
                }
                else if ((oPCinArea == OBJECT_INVALID) && (oPCinObjArea != OBJECT_INVALID)) {
                    //SpeakString("No PC in this area", TALKVOLUME_SHOUT);
                    object oDoor = GetTransitionDoor(GetArea(npcWaypoint.oWaypoint));
                    if (oDoor == OBJECT_INVALID) {
                        ActionJumpToObject(npcWaypoint.oWaypoint, FALSE);
                        ActionWait(5.0);
                    }
                    else {
                        ActionJumpToObject(GetTransitionTarget(oDoor), FALSE);
                        ActionWait(5.0);
                        ActionForceMoveToObject(npcWaypoint.oWaypoint, npcWaypoint.bRunToPoint, fDistance, 70.0);
                        if (npcWaypoint.fDuration < 1.1)    // Cannot allow no-pause here!
                            npcWaypoint.fDuration = 1.1;
                        //SetLocalInt(OBJECT_SELF, "bNoIncWP", TRUE);
                        //return;
                    }
                }
                else if ((oPCinArea != OBJECT_INVALID) && (oPCinObjArea == OBJECT_INVALID)) {
                    //SpeakString("No PC in target area", TALKVOLUME_SHOUT);
                    object oDoor = GetTransitionDoor(GetArea(npcWaypoint.oWaypoint));
                    if (oDoor == OBJECT_INVALID) {
                        //SpeakString("No transition found", TALKVOLUME_SHOUT);
                        ActionJumpToObject(npcWaypoint.oWaypoint, FALSE);
                        ActionWait(5.0);
                    }
                    else {
                        //SpeakString("Moving to door" + GetTag(oDoor), TALKVOLUME_SHOUT);
                        //if (iProcessingLevel == NPC_CPU_DISABLEPATHFINDING) {
                            ActionForceMoveToObject(GetTransitionTarget(oDoor), npcWaypoint.bRunToPoint, fDistance, 70.0);
                            SetLocalInt(OBJECT_SELF, "iPCNear", 0);
                            ActionJumpToObject(npcWaypoint.oWaypoint, FALSE);
                        //}
                        //else
                        //    ActionForceMoveToObject(npcWaypoint.oWaypoint, npcWaypoint.bRunToPoint, fDistance, 70.0);
                        if (npcWaypoint.fDuration < 1.1)    // Cannot allow no-pause here!
                            npcWaypoint.fDuration = 1.1;
                        //SetLocalInt(OBJECT_SELF, "bNoIncWP", TRUE);
                        //return;
                    }
                }
                else {
                    //SpeakString("No PC in either area - teleport", TALKVOLUME_SHOUT);
                    SetLocalInt(OBJECT_SELF, "iPCNear", 0);
                    ActionJumpToObject(npcWaypoint.oWaypoint, FALSE);
                    ActionWait(10.0);
                }
            }
        }

        int bNoPause;

        if (npcWaypoint.fDuration == 0.0) {
            //SpeakString("No pause", TALKVOLUME_SHOUT);
            bNoPause = TRUE;
        }
        else if (npcWaypoint.fDuration < 0.0) {
            //  Random duration:
            npcWaypoint.fDuration = (-npcWaypoint.fDuration/2.0);
            npcWaypoint.fDuration += IntToFloat(Random(FloatToInt(npcWaypoint.fDuration)));
            //SpeakString("Random duration: " + FloatToString(npcWaypoint.fDuration));
        }

        if (npcWaypoint.fDuration < 1.1)
            npcWaypoint.fDuration = 1.1;

        if (bDelayed == TRUE)
            ActionDoCommand(SetLocalInt(OBJECT_SELF, "bIsBusy", iAction));
        else
            SetLocalInt(OBJECT_SELF, "bIsBusy", iAction);

        //string sCommandString;
        switch (iAction) {
        case 0:
            //sCommandString = "Invalid Command!";
            ActionWait(npcWaypoint.fDuration);
            break;
        case 1:
            //sCommandString = "Going to Sleep ...";
            ActionDoCommand(SetFacing(GetFacing(npcWaypoint.oWaypoint)));
            ActionDoCommand(ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSleep(), OBJECT_SELF, npcWaypoint.fDuration));
            ActionWait(1.0);
            break;
        case 12:
            //sCommandString = "Talk salute ...";
            ActionPlayAnimation(ANIMATION_FIREFORGET_SALUTE);
        case 14:    //  Whisper
        case 15:    //  Shout
        case 2:     //  Normal
            {
            int iTalkVolume;
            if (iAction == 15) iTalkVolume = TALKVOLUME_SHOUT;
            else if (iAction == 14) iTalkVolume = TALKVOLUME_WHISPER;
            else iTalkVolume = TALKVOLUME_TALK;
            //sCommandString = "Initiate Conversation ...";
            //ActionPlayAnimation(ANIMATION_FIREFORGET_GREETING);
            SetLocalInt(npcWaypoint.oWaypoint, "TalkVolume", iTalkVolume);
            SetLocalString(npcWaypoint.oWaypoint, "sTalkToNPC", GetTag(OBJECT_SELF));
            SetLocalString(OBJECT_SELF, "sTalkToNPC", GetTag(npcWaypoint.oWaypoint));
            //ActionSpeakString(GetLocalString(OBJECT_SELF, "sNpcGreeting"), iTalkVolume);
            ActionSpeakGreetingPhrase(iTalkVolume);
            ActionDoCommand(SignalEvent(npcWaypoint.oWaypoint, EventUserDefined(201)));
            ActionPlayAnimation(ANIMATION_LOOPING_TALK_NORMAL, 1.0, npcWaypoint.fDuration/2 - 1.0);
            //  Should speak a random string somewhere in here ...
            ActionSpeakRandomPhrase(iTalkVolume);
            ActionPlayAnimation(ANIMATION_LOOPING_TALK_NORMAL, 1.0, npcWaypoint.fDuration/2 - 1.0);
            //ActionSpeakString(GetLocalString(OBJECT_SELF, "sNpcFarewell"), iTalkVolume);
            ActionSpeakFarewellPhrase(iTalkVolume);
            ActionWait(1.0);
            ActionDoCommand(SignalEvent(npcWaypoint.oWaypoint, EventUserDefined(202)));
            }
            break;
        case 3:
            //sCommandString = "Find chair & sit ...";
            ActionDoCommand(DelayCommand(npcWaypoint.fDuration, ClearAllActions()));
            ActionSit(npcWaypoint.oWaypoint);
            break;
        case 4:
            //sCommandString = "Observing ...";
            ActionDoCommand(SetFacing(GetFacing(npcWaypoint.oWaypoint)));
            break;
        case 5:
            //sCommandString = "Working (med)...";
            //  We should turn to face the object ...
            ActionDoCommand(SetFacing(GetFacingFromLocation(GetLocation(npcWaypoint.oWaypoint))));
            if (GetObjectType(npcWaypoint.oWaypoint) != OBJECT_TYPE_DOOR)
            //if (GetIsPlaceableObjectActionPossible(npcWaypoint.oWaypoint,PLACEABLE_ACTION_USE))
                ActionInteractObject(npcWaypoint.oWaypoint);
            ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, npcWaypoint.fDuration - 1.0);
            ActionWait(1.0);
            break;
        case 6:
            //sCommandString = "Waiting ...";
            ActionDoCommand(SetFacing(GetFacing(npcWaypoint.oWaypoint)));
            ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_BORED);
            ActionWait(npcWaypoint.fDuration - 1.0);
            break;
        case 7:
            //sCommandString = "Drinking ...";
            ActionDoCommand(SetFacing(GetFacing(npcWaypoint.oWaypoint)));
            break;
        case 8:
            //sCommandString = "Reading ...";
            ActionDoCommand(SetFacing(GetFacing(npcWaypoint.oWaypoint)));
            break;
        case 9:     //  Stealing (incomplete)
            //sCommandString = "Stealing ...";
            ActionDoCommand(SetFacing(GetFacing(npcWaypoint.oWaypoint)));
            ActionWait(npcWaypoint.fDuration - 1.0);
            break;
        case 10:
            //sCommandString = "Worshipping ...";
            ActionDoCommand(SetFacing(GetFacingFromLocation(GetLocation(npcWaypoint.oWaypoint))));
            ActionPlayAnimation(ANIMATION_LOOPING_WORSHIP, 1.0, npcWaypoint.fDuration - 1.0);
            ActionWait(1.0);
            break;
        case 11:
            //sCommandString = "Working (low) ...";
            //  We should turn to face the object ...
            ActionDoCommand(SetFacing(GetFacingFromLocation(GetLocation(npcWaypoint.oWaypoint))));
            //if (GetIsPlaceableObjectActionPossible(npcWaypoint.oWaypoint,PLACEABLE_ACTION_USE))
                ActionInteractObject(npcWaypoint.oWaypoint);
            ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, npcWaypoint.fDuration - 1.0);
            ActionWait(1.0);
            break;
        case 13:
            //sCommandString = "Sit cross-legged ...";
            ActionDoCommand(SetFacing(GetFacing(npcWaypoint.oWaypoint)));
            ActionPlayAnimation(ANIMATION_LOOPING_SIT_CROSS, 1.0, npcWaypoint.fDuration - 1.0);
            ActionWait(1.0);
            break;
        case 17:
            //sCommandString = "Lock ...";
            //SpeakString("Lock attempt...");
            if (GetObjectType(npcWaypoint.oWaypoint) == OBJECT_TYPE_DOOR) {
                //SpeakString("Close door...");
                ActionCloseDoor(npcWaypoint.oWaypoint);
                ActionDoCommand(SetLocked(npcWaypoint.oWaypoint, TRUE));
            }
            if (GetLockLockable(npcWaypoint.oWaypoint) == TRUE) {
                //SpeakString("Lock object ...");
                ActionDoCommand(SetLocked(npcWaypoint.oWaypoint, TRUE));
                //ActionLockObject(npcWaypoint.oWaypoint);
            }
            ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, npcWaypoint.fDuration - 1.0);
            ActionWait(1.0);
            break;
        case 18:
            //sCommandString = "Unlock ...";
            //if (GetLockLockable(npcWaypoint.oWaypoint) == TRUE) {
            ActionDoCommand(SetLocked(npcWaypoint.oWaypoint, FALSE));
                //ActionUnlockObject(npcWaypoint.oWaypoint);
            //    SpeakString("Unlocked...");
            //}
            //else if (GetObjectType(npcWaypoint.oWaypoint) == OBJECT_TYPE_DOOR) {
            //    SpeakString("Can't Unlock");
            ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, npcWaypoint.fDuration - 1.0);
            ActionWait(1.0);
            break;
        case 19:
            //sCommandString = "Look far ...";
            ActionDoCommand(SetFacing(GetFacing(npcWaypoint.oWaypoint)));
            ActionPlayAnimation(ANIMATION_LOOPING_LOOK_FAR, 1.0, npcWaypoint.fDuration - 1.0);
            ActionWait(1.0);
            break;
        case 20:
            //sCommandString = "open/close ...";
            ActionDoCommand(SetFacing(GetFacingFromLocation(GetLocation(npcWaypoint.oWaypoint))));
            //if (GetObjectType(npcWaypoint.oWaypoint) != OBJECT_TYPE_DOOR)
            //   ActionInteractObject(npcWaypoint.oWaypoint);
            ActionDoCommand(AssignCommand(npcWaypoint.oWaypoint, PlayAnimation(ANIMATION_PLACEABLE_OPEN)));
            ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, npcWaypoint.fDuration - 1.0);
            ActionDoCommand(AssignCommand(npcWaypoint.oWaypoint, PlayAnimation(ANIMATION_PLACEABLE_CLOSE)));
            ActionWait(1.0);
            break;
        case 21:
            //sCommandString = "Random walk ...";
            break;
        case 22:
            //sCommandString = "Change clothes ...";
            ActionEquipItem(npcWaypoint.oWaypoint, INVENTORY_SLOT_CHEST);
            ActionWait(npcWaypoint.fDuration - 1.0);
            break;
        case 23:
            //sCommandString = "Announcement ...";
            ActionSpeakAnnouncePhrase();
            //ActionSpeakString(GetLocalString(OBJECT_SELF, "sNpcAnnounce"));
            ActionWait(npcWaypoint.fDuration - 1.0);
            break;
        case 24:
            //sCommandString = "Attack/hit object ...";
            ActionEquipMostDamagingMelee();
            //  Problem with this command, because it flags the NPC as in combat.
            break;
        case 25:
            //sCommandString = "Execute script 1 ...";
            //if (GetLocalString(OBJECT_SELF, "sNpcExecute", sScriptName))
            //SpeakString("Script: " + GetLocalString(OBJECT_SELF, "sNpcExecute1"));
            ExecuteScript(GetLocalString(OBJECT_SELF, "sNpcExecute1"), OBJECT_SELF);
            break;
        case 26:
            //sCommandString = "Execute script 2 ...";
            //if (GetLocalString(OBJECT_SELF, "sNpcExecute", sScriptName))
            ExecuteScript(GetLocalString(OBJECT_SELF, "sNpcExecute2"), OBJECT_SELF);
            break;
        case 27:
            //sCommandString = "Destroy object (can be myself) ...";
            ActionDoCommand(DestroyObject(npcWaypoint.oWaypoint, npcWaypoint.fDuration));
            break;
        case 28:
            //sCommandString = "Play sound ...";
            ActionDoCommand(SoundObjectPlay(npcWaypoint.oWaypoint));
            ActionDoCommand(DelayCommand(npcWaypoint.fDuration - 1.0, SoundObjectStop(npcWaypoint.oWaypoint)));
            ActionWait(npcWaypoint.fDuration - 1.0);
            break;
        case 29:
            //sCommandString = "Start conversation ...";
            ActionStartConversation(npcWaypoint.oWaypoint, GetLocalString(OBJECT_SELF, "sNpcConv"));
            ActionWait(npcWaypoint.fDuration - 1.0);
            break;
        case 30:
            //sCommandString = "Reset the local events 1, 2, 3 & 4 ...";
            if (bNoPause == TRUE) {
                SetLocalInt(OBJECT_SELF, "iEvent", 0);
                SetLocalInt(OBJECT_SELF, "CurrentWaypoint", GetLocalInt(OBJECT_SELF, "iPreEventWp"));
            }
            else {
                ActionDoCommand(SetLocalInt(OBJECT_SELF, "iEvent", 0));
                ActionDoCommand(SetLocalInt(OBJECT_SELF, "CurrentWaypoint", GetLocalInt(OBJECT_SELF, "iPreEventWp")));
            }
            break;
        case 31:
            //sCommandString = "Activate event 1 ...";
            ActionDoCommand(SetEventResponse(1, TRUE));
            break;
        case 32:
            //sCommandString = "deactivate event 1 ...";
            ActionDoCommand(SetEventResponse(1, FALSE));
            break;
        case 33:
            //sCommandString = "Activate event 2 ...";
            ActionDoCommand(SetEventResponse(2, TRUE));
            break;
        case 34:
            //sCommandString = "deactivate event 2 ...";
            ActionDoCommand(SetEventResponse(2, FALSE));
            break;
        case 35:
            //sCommandString = "Activate event 1 ...";
            ActionDoCommand(SetEventResponse(3, TRUE));
            break;
        case 36:
            //sCommandString = "Deactivate event 1 ...";
            ActionDoCommand(SetEventResponse(3, FALSE));
            break;
        case 37:
            //sCommandString = "Activate event 2 ...";
            ActionDoCommand(SetEventResponse(4, TRUE));
            break;
        case 38:
            //sCommandString = "Deactivate event 2 ...";
            ActionDoCommand(SetEventResponse(4, FALSE));
            break;
        case 39:
            //sCommandString = "Reset area events ...";
            ActionDoCommand(ClearAreaEvents());
            break;
        case 40:
            //sCommandString = "Trigger area event 1 ...";
            ActionDoCommand(CreateAlarm(npcWaypoint.oWaypoint, npcWaypoint.fDuration, FALSE, 1));
            break;
        case 41:
            //sCommandString = "Trigger area event 2 ...";
            ActionDoCommand(CreateAlarm(npcWaypoint.oWaypoint, npcWaypoint.fDuration, FALSE, 2));
            break;
        case 42:
            //sCommandString = "Trigger area event 3 ...";
            ActionDoCommand(CreateAlarm(npcWaypoint.oWaypoint, npcWaypoint.fDuration, FALSE, 3));
            break;
        case 43:
            //sCommandString = "Trigger area event 4 ...";
            ActionDoCommand(CreateAlarm(npcWaypoint.oWaypoint, npcWaypoint.fDuration, FALSE, 4));
            break;
        case 44:
            //sCommandString = "Trigger NPC event 1 ...";
            if (bNoPause == TRUE)
                TriggerNPCEvent(npcWaypoint.oWaypoint, OBJECT_SELF, 0.0, 1);
            else
                ActionDoCommand(TriggerNPCEvent(npcWaypoint.oWaypoint, OBJECT_SELF, 0.0, 1));
            break;
        case 45:
            //sCommandString = "Trigger NPC event 2 ...";
            if (bNoPause == TRUE)
                TriggerNPCEvent(npcWaypoint.oWaypoint, OBJECT_SELF, 0.0, 2);
            else
                ActionDoCommand(TriggerNPCEvent(npcWaypoint.oWaypoint, OBJECT_SELF, 0.0, 2));
            break;
        case 46:
            //sCommandString = "Trigger NPC event 3 ...";
            if (bNoPause == TRUE)
                TriggerNPCEvent(npcWaypoint.oWaypoint, OBJECT_SELF, 0.0, 3);
            else
                ActionDoCommand(TriggerNPCEvent(npcWaypoint.oWaypoint, OBJECT_SELF, 0.0, 3));
            break;
        case 47:
            //sCommandString = "Trigger NPC event 4 ...";
            if (bNoPause == TRUE)
                TriggerNPCEvent(npcWaypoint.oWaypoint, OBJECT_SELF, 0.0, 4);
            else
                ActionDoCommand(TriggerNPCEvent(npcWaypoint.oWaypoint, OBJECT_SELF, 0.0, 4));
            break;
        case 60:
            //sCommandString = "Move sound object & play it ...";
            ActionDoCommand(SoundObjectSetPosition(npcWaypoint.oWaypoint, GetPosition(npcWaypoint.oWaypoint)));
            ActionDoCommand(SoundObjectPlay(npcWaypoint.oWaypoint));
            ActionDoCommand(DelayCommand(npcWaypoint.fDuration - 1.0, SoundObjectStop(npcWaypoint.oWaypoint)));
            ActionWait(npcWaypoint.fDuration - 1.0);
            break;
        case 61:
            //sCommandString = "Set friend ...";
            ActionDoCommand(SetIsTemporaryFriend(npcWaypoint.oWaypoint));
            break;
        case 62:
            //sCommandString = "Set neutral ...";
            ActionDoCommand(SetIsTemporaryNeutral(npcWaypoint.oWaypoint));
            break;
        case 63:
            //sCommandString = "Set friend ...";
            ActionDoCommand(SetIsTemporaryEnemy(npcWaypoint.oWaypoint));
            break;
        case 64:
            //sCommandString = "Set faction ...";
            ActionDoCommand(ChangeFaction(OBJECT_SELF, npcWaypoint.oWaypoint));
            break;
        case 81:
            //sCommandString = "Meditating ...";
            ActionDoCommand(SetFacing(GetFacingFromLocation(GetLocation(npcWaypoint.oWaypoint))));
            ActionPlayAnimation(ANIMATION_LOOPING_MEDITATE, 1.0, npcWaypoint.fDuration - 1.0);
            ActionWait(1.0);
            break;
        case 82:
            //sCommandString = "Drunk ...";
            ActionDoCommand(SetFacing(GetFacingFromLocation(GetLocation(npcWaypoint.oWaypoint))));
            ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK, 1.0, npcWaypoint.fDuration - 1.0);
            ActionWait(1.0);
            break;
        default:
            //sCommandString = "Command is not recognised!";
            break;
        }

        //  Check if action is to be completed immediately
        if ((bNoPause == TRUE) &&
            ((iAction == NPC_COMMAND_FASTWALK) || ((iAction > 29) && (iAction < 80)))) {
            int iRecursionCount = GetLocalInt(OBJECT_SELF, "iRecCount");
            if (iRecursionCount < 6) {
                ActionDoTasks(TRUE);    //  Recursion ...
                SetLocalInt(OBJECT_SELF, "iRecCount", iRecursionCount + 1);
            }
            else
                SetLocalInt(OBJECT_SELF, "iRecCount", 0);
        }
        else
            SetLocalInt(OBJECT_SELF, "iRecCount", 0);

        if (iChoreNum != -1) {
            //SpeakString("Set chore value", TALKVOLUME_TALK);
            //  Done after move, so that it is only set if the chore is completed.
            ActionDoCommand(SetLocalInt(OBJECT_SELF, "iChoreNumber", 0));
        }

        //ActionDoCommand(SetLocalInt(OBJECT_SELF, "bIsBusy", FALSE));

        //ActionSpeakString(sCommandString, TALKVOLUME_TALK);
        SetLocalInt(OBJECT_SELF, "bStartTimer", FALSE);
        SetLocalFloat(OBJECT_SELF, "fTimerDuration", npcWaypoint.fDuration);
    }

    //SpeakString("Action #" + IntToString(iAction));

    switch (iAction) {
    case 4:     //Observing ...
        ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_LEFT);
        ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_RIGHT);
        //ActionWait(npcWaypoint.fDuration);
        SetLocalInt(OBJECT_SELF, "iContinuedAction", NPC_COMMAND_OBSERVE);
        break;
    case 7:     //Drinking ...
        ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK);
        ActionWait(1.0);
        ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK);
        ActionWait(1.0);
        SetLocalInt(OBJECT_SELF, "iContinuedAction", NPC_COMMAND_DRINK);
        break;
    case 8:     //Reading ...
        ActionPlayAnimation(ANIMATION_FIREFORGET_READ);
        ActionWait(1.5);
        ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD);
        ActionWait(1.0);
        SetLocalInt(OBJECT_SELF, "iContinuedAction", NPC_COMMAND_READ);
        break;
    case 21:  //  Random walk ...
        if (GetLocalInt(OBJECT_SELF, "bIsBusy") == FALSE) {
            ActionRandomWalk();
            ActionWait(3.0);
        }
        SetLocalInt(OBJECT_SELF, "iContinuedAction", NPC_COMMAND_RANDOMWALK);
        break;
    case 24: {//  Attack object.
        object oNpcObject = GetLocalObject(OBJECT_SELF, "oNpcObject");
        if (oNpcObject != OBJECT_INVALID) {
            if (GetObjectType(oNpcObject) == OBJECT_TYPE_PLACEABLE) {
                ActionDoCommand(DoPlaceableObjectAction(oNpcObject, PLACEABLE_ACTION_BASH));
            }
            else if (GetObjectType(npcWaypoint.oWaypoint) == OBJECT_TYPE_DOOR) {
                ActionDoCommand(DoPlaceableObjectAction(oNpcObject, PLACEABLE_ACTION_BASH));
            }
            else {
                ActionAttack(oNpcObject);
            }
            SetLocalInt(OBJECT_SELF, "iContinuedAction", 24);
        }
        else
            SetLocalInt(OBJECT_SELF, "iContinuedAction", 0);
        break;
    }
    default:    //Command is not recognised!
        SetLocalInt(OBJECT_SELF, "iContinuedAction", 0);
        break;
    }
}

