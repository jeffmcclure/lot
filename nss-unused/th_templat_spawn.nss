//  This is an initial script to test my general NPC script


#include "NW_O2_CONINCLUDE"
#include "NW_I0_GENERIC"
#include "th_npc_include"

void main()
{
    // OPTIONAL BEHAVIORS (Comment In or Out to Activate ) ****************************************************************************
     //SetSpawnInCondition(NW_FLAG_SPECIAL_CONVERSATION);
     //SetSpawnInCondition(NW_FLAG_SPECIAL_COMBAT_CONVERSATION);
                // This causes the creature to say a special greeting in their conversation file
                // upon Perceiving the player. Attach the [NW_D2_GenCheck.nss] script to the desired
                // greeting in order to designate it. As the creature is actually saying this to
                // himself, don't attach any player responses to the greeting.

     //SetSpawnInCondition(NW_FLAG_SHOUT_ATTACK_MY_TARGET);
                // This will set the listening pattern on the NPC to attack when allies call
     //SetSpawnInCondition(NW_FLAG_STEALTH);
                // If the NPC has stealth and they are a rogue go into stealth mode
     //SetSpawnInCondition(NW_FLAG_SEARCH);
                // If the NPC has Search go into Search Mode
     //SetSpawnInCondition(NW_FLAG_SET_WARNINGS);
                // This will set the NPC to give a warning to non-enemies before attacking

     //SetSpawnInCondition(NW_FLAG_SLEEP);
                //Creatures that spawn in during the night will be asleep.
     //SetSpawnInCondition(NW_FLAG_DAY_NIGHT_POSTING);
     //SetSpawnInCondition(NW_FLAG_APPEAR_SPAWN_IN_ANIMATION);
     //SetSpawnInCondition(NW_FLAG_IMMOBILE_AMBIENT_ANIMATIONS);
     //SetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS);
                //This will play Ambient Animations until the NPC sees an enemy or is cleared.
                //NOTE that these animations will play automatically for Encounter Creatures.

    // NOTE: ONLY ONE OF THE FOLOOWING ESCAPE COMMANDS SHOULD EVER BE ACTIVATED AT ANY ONE TIME.
    //SetSpawnInCondition(NW_FLAG_ESCAPE_RETURN);    // OPTIONAL BEHAVIOR (Flee to a way point and return a short time later.)
    //SetSpawnInCondition(NW_FLAG_ESCAPE_LEAVE);     // OPTIONAL BEHAVIOR (Flee to a way point and do not return.)
    //SetSpawnInCondition(NW_FLAG_TELEPORT_LEAVE);   // OPTIONAL BEHAVIOR (Teleport to safety and do not return.)
    //SetSpawnInCondition(NW_FLAG_TELEPORT_RETURN);  // OPTIONAL BEHAVIOR (Teleport to safety and return a short time later.)

// CUSTOM USER DEFINED EVENTS
/*
    The following settings will allow the user to fire one of the blank user defined events in the NW_D2_DefaultD.  Like the
    On Spawn In script this script is meant to be customized by the end user to allow for unique behaviors.  The user defined
    events user 1000 - 1010
*/
    SetSpawnInCondition(NW_FLAG_HEARTBEAT_EVENT);        //OPTIONAL BEHAVIOR - Fire User Defined Event 1001
    //SetSpawnInCondition(NW_FLAG_PERCIEVE_EVENT);         //OPTIONAL BEHAVIOR - Fire User Defined Event 1002
    //SetSpawnInCondition(NW_FLAG_ATTACK_EVENT);           //OPTIONAL BEHAVIOR - Fire User Defined Event 1005
    //SetSpawnInCondition(NW_FLAG_DAMAGED_EVENT);          //OPTIONAL BEHAVIOR - Fire User Defined Event 1006
    //SetSpawnInCondition(NW_FLAG_DISTURBED_EVENT);        //OPTIONAL BEHAVIOR - Fire User Defined Event 1008
    //SetSpawnInCondition(NW_FLAG_END_COMBAT_ROUND_EVENT); //OPTIONAL BEHAVIOR - Fire User Defined Event 1003
    //SetSpawnInCondition(NW_FLAG_ON_DIALOGUE_EVENT);      //OPTIONAL BEHAVIOR - Fire User Defined Event 1004
    //SetSpawnInCondition(NW_FLAG_DEATH_EVENT);            //OPTIONAL BEHAVIOR - Fire User Defined Event 1007

    // DEFAULT GENERIC BEHAVIOR (DO NOT TOUCH) *****************************************************************************************
    SetListeningPatterns();    // Goes through and sets up which shouts the NPC will listen to.
    GenerateNPCTreasure();     //* Use this to create a small amount of treasure on the creature

    //  Reset all waypoints to start.
    RemoveAllTasks();

    //  Task order circular (NPC_WPTYPE_CIRCULAR) or random(NPC_WPTYPE_RANDOM)
    SetTaskOrder(NPC_WPTYPE_CIRCULAR);

    //  Set working hours (for a special set of tasks - NPC_TIME_WORKHOURS)
    SetWorkHours(16, 17);

    //  Only call these functions if I have conversations with other NPCs.
    ClearPhrases();
    //SetGreetingPhrase("cv_greet_hansel");
    //SetFarewellPhrase("Bye bye.");
    //SetAnnouncePhrase("cv_announce");
    //AddRandomPhrase("How's everything?");
    //AddRandomPhrase("How's it hangin'?");
    //AddRandomPhrase("cv_hansel");
    //SetThiefConversation("cv_thief");

    // Set custom executable scripts
    //SetExecutableScript1("cast_stoneskin");

    //  Set objects I need to guard (I can have as many as I need).
    //GuardContainer("TowneChest");

    //  Events responded to ...
    //SetEventResponse(1, TRUE);
    //SetEventResponse(2, TRUE);

    //  Set a script to execute on the perceive event:
    //SetPerceiveScript("guard_perceive");

    //  NPC CPU processing level (when there are no PCs in the area)
    //NPC_CPU_FULL           NPC_CPU_DISABLEPATHFINDING   NPC_CPU_NONE
    SetNPCProcessingLevel(NPC_CPU_FULL);

    struct sNpcTask        npcTask;
    object                 oWayPoint;

/*
*** Possible actions for copy/pasting
NPC_COMMAND_SLEEP           NPC_COMMAND_TALKNORMAL      NPC_COMMAND_SIT
NPC_COMMAND_OBSERVE         NPC_COMMAND_USEOBJECTMED    NPC_COMMAND_WAIT
NPC_COMMAND_DRINK           NPC_COMMAND_READ            NPC_COMMAND_WORSHIP
NPC_COMMAND_USEOBJECTLOW    NPC_COMMAND_TALKSALUTE      NPC_COMMAND_SITCROSS
NPC_COMMAND_TALKWHISPER     NPC_COMMAND_TALKSHOUT       NPC_COMMAND_JUMPTOLOCATION
NPC_COMMAND_CLOSELOCK       NPC_COMMAND_UNLOCK          NPC_COMMAND_LOOKFAR
NPC_COMMAND_OPENCLOSE       NPC_COMMAND_RANDOMWALK      NPC_COMMAND_CHANGECLOTHES
NPC_COMMAND_ANNOUNCE        NPC_COMMAND_EXECUTESCRIPT1  NPC_COMMAND_EXECUTESCRIPT2
NPC_COMMAND_DESTROYOBJECT   NPC_COMMAND_PLAYSOUND       NPC_COMMAND_CONVERSATION
NPC_COMMAND_RESETEVENT      NPC_COMMAND_ENABLEEVENT1    NPC_COMMAND_DISABLEEVENT1
NPC_COMMAND_ENABLEEVENT2    NPC_COMMAND_DISABLEEVENT2   NPC_COMMAND_ENABLEEVENT3
NPC_COMMAND_DISABLEEVENT3   NPC_COMMAND_ENABLEEVENT4    NPC_COMMAND_DISABLEEVENT4
NPC_COMMAND_RESETAREAEVENT  NPC_COMMAND_TRIGAREAEVENT1  NPC_COMMAND_TRIGAREAEVENT2
NPC_COMMAND_TRIGAREAEVENT3  NPC_COMMAND_TRIGAREAEVENT4  NPC_COMMAND_TRIGLOCEVENT1
NPC_COMMAND_TRIGLOCEVENT2   NPC_COMMAND_TRIGLOCEVENT3   NPC_COMMAND_TRIGLOCEVENT4
NPC_COMMAND_SOUNDOBJMOVPLAY NPC_COMMAND_SETFRIEND       NPC_COMMAND_SETNEUTRAL
NPC_COMMAND_SETENEMY        NPC_COMMAND_SETFACTION      NPC_COMMAND_FASTWALK
NPC_COMMAND_MEDITATE        NPC_COMMAND_DRUNK

*** Possible times(dayNight) for copy/pasting
NPC_TIME_ALWAYS             NPC_TIME_DAY                NPC_TIME_NIGHT
NPC_TIME_EXACTTIME          NPC_TIME_WORKHOURS          NPC_TIME_EVENTTRIGGERED1
NPC_TIME_EVENTTRIGGERED2    NPC_TIME_EVENTTRIGGERED3    NPC_TIME_EVENTTRIGGERED4
*/

    //  Set daytime waypoint/task 1 (Change into day clothes)
    oWayPoint = GetObjectByTag("NW_CLOTH001");
    npcTask.oWaypoint = oWayPoint;
    npcTask.associatedCommand = NPC_COMMAND_CHANGECLOTHES;
    npcTask.dayNight = NPC_TIME_DAY;
    npcTask.fDuration = 4.0;
    npcTask.bRunToPoint = FALSE;
    AddTask(npcTask);

    //  Set daytime waypoint/task 2 (Observe from lookout)
    oWayPoint = GetObjectByTag("TOWER_WP1");
    npcTask.oWaypoint = oWayPoint;
    npcTask.associatedCommand = NPC_COMMAND_LOOKFAR;
    npcTask.dayNight = NPC_TIME_DAY;
    npcTask.fDuration = 15.0;
    npcTask.bRunToPoint = FALSE;
    AddTask(npcTask);

    //  Set daytime waypoint/task 3 (Make announcement at the crossroads)
    oWayPoint = GetObjectByTag("CROSSROADS_WP2");
    npcTask.oWaypoint = oWayPoint;
    npcTask.associatedCommand = NPC_COMMAND_ANNOUNCE;
    npcTask.dayNight = NPC_TIME_DAY;
    npcTask.fDuration = 4.0;
    npcTask.bRunToPoint = TRUE;
    AddTask(npcTask);

    //  Set daytime waypoint/task 4 (Starts a conversation with Mugatu)
    oWayPoint = GetObjectByTag("Mugatu");
    npcTask.oWaypoint = oWayPoint;
    npcTask.associatedCommand = NPC_COMMAND_TALKNORMAL;
    npcTask.dayNight = NPC_TIME_DAY;
    npcTask.fDuration = 32.0;
    npcTask.bRunToPoint = TRUE;
    AddTask(npcTask);

    //  Set daytime waypoint/task 5 (Talk to the doggy)
    oWayPoint = GetObjectByTag("NW_DOG");
    npcTask.oWaypoint = oWayPoint;
    npcTask.associatedCommand = NPC_COMMAND_TALKNORMAL;
    npcTask.dayNight = NPC_TIME_DAY;
    npcTask.fDuration = 10.0;
    npcTask.bRunToPoint = TRUE;
    AddTask(npcTask);

    //  Set daytime waypoint/task 6 (Starts a conversation with Mugatu)
    oWayPoint = GetObjectByTag("Mugatu");
    npcTask.oWaypoint = oWayPoint;
    npcTask.associatedCommand = NPC_COMMAND_TALKNORMAL;
    npcTask.dayNight = NPC_TIME_DAY;
    npcTask.fDuration = 32.0;
    npcTask.bRunToPoint = TRUE;
    AddTask(npcTask);

    //  Set daytime waypoint/task 5 (Custom script)
    oWayPoint = GetObjectByTag("NW_DOG");
    npcTask.oWaypoint = oWayPoint;
    npcTask.associatedCommand = NPC_COMMAND_EXECUTESCRIPT1;
    npcTask.dayNight = NPC_TIME_DAY;
    npcTask.fDuration = 10.0;
    npcTask.bRunToPoint = TRUE;
    AddTask(npcTask);

    //  Set daytime waypoint/task 7 (Starts a conversation with Siam)
    oWayPoint = GetObjectByTag("Siam");
    npcTask.oWaypoint = oWayPoint;
    npcTask.associatedCommand = NPC_COMMAND_TALKNORMAL;
    npcTask.dayNight = NPC_TIME_DAY;
    npcTask.fDuration = 30.0;
    npcTask.bRunToPoint = TRUE;
    AddTask(npcTask);

    //  Set daytime waypoint/task 8 (Open & close the chest)
    oWayPoint = GetObjectByTag("TowneChest");
    npcTask.oWaypoint = oWayPoint;
    npcTask.associatedCommand = NPC_COMMAND_OPENCLOSE;
    npcTask.dayNight = NPC_TIME_DAY;
    npcTask.fDuration = 6.0;
    npcTask.bRunToPoint = TRUE;
    AddTask(npcTask);

    //  Set daytime waypoint/task 9 (Reads by the chest)
    oWayPoint = GetObjectByTag("TowneChest");
    npcTask.oWaypoint = oWayPoint;
    npcTask.associatedCommand = NPC_COMMAND_READ;
    npcTask.dayNight = NPC_TIME_DAY;
    npcTask.fDuration = 10.0;
    npcTask.bRunToPoint = TRUE;
    AddTask(npcTask);

    //  Set daytime waypoint/task 10 (Locks the chest)
    oWayPoint = GetObjectByTag("TowneChest");
    npcTask.oWaypoint = oWayPoint;
    npcTask.associatedCommand = NPC_COMMAND_CLOSELOCK;
    npcTask.dayNight = NPC_TIME_DAY;
    npcTask.fDuration = 5.0;
    npcTask.bRunToPoint = FALSE;
    AddTask(npcTask);

    //  Set work waypoint/task 1 (Plays in the fields)
    oWayPoint = GetObjectByTag("FIELD_WP1");
    npcTask.oWaypoint = oWayPoint;
    npcTask.associatedCommand = NPC_COMMAND_USEOBJECTLOW;
    npcTask.dayNight = NPC_TIME_WORKHOURS;
    npcTask.fDuration = 8.0;
    npcTask.bRunToPoint = FALSE;
    AddTask(npcTask);

    //  Set work waypoint/task 2 (Plays in the fields)
    oWayPoint = GetObjectByTag("FIELD_WP2");
    npcTask.oWaypoint = oWayPoint;
    npcTask.associatedCommand = NPC_COMMAND_USEOBJECTLOW;
    npcTask.dayNight = NPC_TIME_WORKHOURS;
    npcTask.fDuration = 8.0;
    npcTask.bRunToPoint = FALSE;
    AddTask(npcTask);

    //  Set work waypoint/task 3 (Uses the well)
    oWayPoint = GetObjectByTag("TowneWell");
    npcTask.oWaypoint = oWayPoint;
    npcTask.associatedCommand = NPC_COMMAND_USEOBJECTMED;
    npcTask.dayNight = NPC_TIME_WORKHOURS;
    npcTask.fDuration = 8.0;
    npcTask.bRunToPoint = FALSE;
    AddTask(npcTask);

    //  Set exact time waypoint/task (Turns on/off the lamp at 2100)
    oWayPoint = GetObjectByTag("TowneLamp");
    npcTask.oWaypoint = oWayPoint;
    npcTask.associatedCommand = NPC_COMMAND_USEOBJECTMED;
    npcTask.dayNight = NPC_TIME_EXACTTIME;
    npcTask.fDuration = 5.0;
    npcTask.bRunToPoint = FALSE;
    AddTask(npcTask, 21);

    //  Set exact time waypoint/task (Turns on/off the lamp at 0300)
    oWayPoint = GetObjectByTag("TowneLamp");
    npcTask.oWaypoint = oWayPoint;
    npcTask.associatedCommand = NPC_COMMAND_USEOBJECTMED;
    npcTask.dayNight = NPC_TIME_EXACTTIME;
    npcTask.fDuration = 5.0;
    npcTask.bRunToPoint = FALSE;
    AddTask(npcTask, 3);

    //  Set nighttime waypoint/task 1 (Turns on/off the candelabra)
    oWayPoint = GetObjectByTag("TardisCandelabra");
    npcTask.oWaypoint = oWayPoint;
    npcTask.associatedCommand = NPC_COMMAND_USEOBJECTMED;
    npcTask.dayNight = NPC_TIME_NIGHT;
    npcTask.fDuration = 5.0;
    npcTask.bRunToPoint = FALSE;
    AddTask(npcTask);

    //  Set nighttime waypoint/task 2 (Change into nighttime clothes)
    oWayPoint = GetObjectByTag("NW_CLOTH020");
    npcTask.oWaypoint = oWayPoint;
    npcTask.associatedCommand = NPC_COMMAND_CHANGECLOTHES;
    npcTask.dayNight = NPC_TIME_NIGHT;
    npcTask.fDuration = 2.0;
    npcTask.bRunToPoint = FALSE;
    AddTask(npcTask);

    //  Set nighttime waypoint/task 3 (Sits in the chair)
    oWayPoint = GetObjectByTag("TardisChair");
    npcTask.oWaypoint = oWayPoint;
    npcTask.associatedCommand = NPC_COMMAND_SIT;
    npcTask.dayNight = NPC_TIME_NIGHT;
    npcTask.fDuration = 15.0;
    npcTask.bRunToPoint = FALSE;
    AddTask(npcTask);

    //  Set nighttime waypoint/task 4 (Use oven)
    oWayPoint = GetObjectByTag("TardisOven");
    npcTask.oWaypoint = oWayPoint;
    npcTask.associatedCommand = NPC_COMMAND_USEOBJECTLOW;
    npcTask.dayNight = NPC_TIME_NIGHT;
    npcTask.fDuration = 8.0;
    npcTask.bRunToPoint = FALSE;
    AddTask(npcTask);

    //  Set nighttime waypoint/task 5 (Use keg)
    oWayPoint = GetObjectByTag("TardisKeg");
    npcTask.oWaypoint = oWayPoint;
    npcTask.associatedCommand = NPC_COMMAND_USEOBJECTLOW;
    npcTask.dayNight = NPC_TIME_NIGHT;
    npcTask.fDuration = 8.0;
    npcTask.bRunToPoint = FALSE;
    AddTask(npcTask);

    //  Set nighttime waypoint/task 6 (Have a drink)
    oWayPoint = GetObjectByTag("TardisKeg");
    npcTask.oWaypoint = oWayPoint;
    npcTask.associatedCommand = NPC_COMMAND_DRINK;
    npcTask.dayNight = NPC_TIME_NIGHT;
    npcTask.fDuration = 8.0;
    npcTask.bRunToPoint = FALSE;
    AddTask(npcTask);

/*
    //  Set nighttime waypoint/task 7 (Sit cross-legged on bedroll)
    oWayPoint = GetObjectByTag("TardisBedRoll");
    npcTask.oWaypoint = oWayPoint;
    npcTask.associatedCommand = NPC_COMMAND_SITCROSS;
    npcTask.dayNight = NPC_TIME_NIGHT;
    npcTask.fDuration = 20.0;
    npcTask.bRunToPoint = FALSE;
    AddTask(npcTask);
*/
    //  Set nighttime waypoint/task 7 (Sleep on bedroll)
    oWayPoint = GetObjectByTag("SLEEP_WP");
    npcTask.oWaypoint = oWayPoint;
    npcTask.associatedCommand = NPC_COMMAND_SLEEP;
    npcTask.dayNight = NPC_TIME_NIGHT;
    npcTask.fDuration = 30.0;
    npcTask.bRunToPoint = FALSE;
    AddTask(npcTask);
}




