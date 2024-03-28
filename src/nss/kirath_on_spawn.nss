#include "x0_inc_henai"
#include "x2_inc_banter"
#include "x2_inc_globals"
#include "NW_I0_GENERIC"

void main()
{
    SetListening(OBJECT_SELF, TRUE);
    SetAssociateListenPatterns();//Sets up the special henchmen listening patterns
    SetListeningPatterns();      // Goes through and sets up which shouts the NPC will listen to.
    //SetListenPattern(OBJECT_SELF,"assassinate",1);
    //SetListenPattern(OBJECT_SELF,"Assassinate",1);
    //SetListenPattern(OBJECT_SELF,"disarm trap",2);
    //SetListenPattern(OBJECT_SELF,"Disarm Trap",2);
    //SetListenPattern(OBJECT_SELF,"Disarm trap",2);
    //SetListenPattern(OBJECT_SELF,"open lock",3);
    //SetListenPattern(OBJECT_SELF,"Open Lock",3);
    //SetListenPattern(OBJECT_SELF,"Open lock",3);
    SetListenPattern(OBJECT_SELF,"Kirath hide",4);
    SetListenPattern(OBJECT_SELF,"Kirath Hide",4);
    SetListenPattern(OBJECT_SELF,"kirath hide",4);
    SetListenPattern(OBJECT_SELF,"kirath Hide",4);

    SetListenPattern(OBJECT_SELF,"hide",5);
    SetListenPattern(OBJECT_SELF,"Hide",5);

    SetListenPattern(OBJECT_SELF,"Kirath arm melee",6);
    SetListenPattern(OBJECT_SELF,"Kirath Arm melee",6);
    SetListenPattern(OBJECT_SELF,"Kirath arm Melee",6);
    SetListenPattern(OBJECT_SELF,"Kirath Arm Melee",6);
    SetListenPattern(OBJECT_SELF,"kirath arm melee",6);
    SetListenPattern(OBJECT_SELF,"kirath Arm melee",6);
    SetListenPattern(OBJECT_SELF,"kirath arm Melee",6);
    SetListenPattern(OBJECT_SELF,"kirath Arm Melee",6);

    SetListenPattern(OBJECT_SELF,"Kirath arm ranged",7);
    SetListenPattern(OBJECT_SELF,"Kirath Arm ranged",7);
    SetListenPattern(OBJECT_SELF,"Kirath arm Ranged",7);
    SetListenPattern(OBJECT_SELF,"Kirath Arm Ranged",7);
    SetListenPattern(OBJECT_SELF,"kirath arm ranged",7);
    SetListenPattern(OBJECT_SELF,"kirath Arm ranged",7);
    SetListenPattern(OBJECT_SELF,"kirath arm Ranged",7);
    SetListenPattern(OBJECT_SELF,"kirath Arm Ranged",7);

    SetListenPattern(OBJECT_SELF,"Kirath come here",12);
    SetListenPattern(OBJECT_SELF,"Kirath Come here",12);
    SetListenPattern(OBJECT_SELF,"Kirath Come Here",12);
    SetListenPattern(OBJECT_SELF,"kirath come here",12);
    SetListenPattern(OBJECT_SELF,"kirath Come here",12);
    SetListenPattern(OBJECT_SELF,"kirath Come Here",12);

    SetListenPattern(OBJECT_SELF,"come here",13);
    SetListenPattern(OBJECT_SELF,"Come here",13);
    SetListenPattern(OBJECT_SELF,"Come Here",13);

    //SetListenPattern(OBJECT_SELF,"talk to me",14);

    SetListenPattern(OBJECT_SELF,"Kirath attack",14);
    SetListenPattern(OBJECT_SELF,"Kirath Attack",14);
    SetListenPattern(OBJECT_SELF,"kirath attack",14);
    SetListenPattern(OBJECT_SELF,"kirath Attack",14);

    SetListenPattern(OBJECT_SELF,"attack",15);
    SetListenPattern(OBJECT_SELF,"Attack",15);

    //SetListenPattern(OBJECT_SELF,"cast **",16);
    //SetListenPattern(OBJECT_SELF,"Cast **",16);

    SetListenPattern(OBJECT_SELF,"Kirath wait there",16);
    SetListenPattern(OBJECT_SELF,"Kirath Wait there",16);
    SetListenPattern(OBJECT_SELF,"Kirath Wait There",16);
    SetListenPattern(OBJECT_SELF,"kirath wait there",16);
    SetListenPattern(OBJECT_SELF,"kirath Wait there",16);
    SetListenPattern(OBJECT_SELF,"kirath Wait There",16);

    SetListenPattern(OBJECT_SELF,"wait there",17);
    SetListenPattern(OBJECT_SELF,"Wait there",17);
    SetListenPattern(OBJECT_SELF,"Wait There",17);

    //SetListenPattern(OBJECT_SELF,"How close",18);
    //SetListenPattern(OBJECT_SELF,"How Close",18);
    //SetListenPattern(OBJECT_SELF,"how close",18);

    //SetListenPattern(OBJECT_SELF,"stop",19);
    //SetListenPattern(OBJECT_SELF,"Stop",19);

    //SetListenPattern(OBJECT_SELF,"toggle walkers",20);
    //SetListenPattern(OBJECT_SELF,"Toggle Walkers",20);

    SetListenPattern(OBJECT_SELF,"Kirath fall back",20);
    SetListenPattern(OBJECT_SELF,"Kirath Fall back",20);
    SetListenPattern(OBJECT_SELF,"Kirath Fall Back",20);
    SetListenPattern(OBJECT_SELF,"kirath fall back",20);
    SetListenPattern(OBJECT_SELF,"kirath Fall back",20);
    SetListenPattern(OBJECT_SELF,"kirath Fall Back",20);

    SetListenPattern(OBJECT_SELF,"fall back",21);
    SetListenPattern(OBJECT_SELF,"Fall back",21);
    SetListenPattern(OBJECT_SELF,"Fall Back",21);

    //SetListenPattern(OBJECT_SELF,"ALPHA4",92);
    //SetListenPattern(OBJECT_SELF,"Mokura",93);
    //SetListenPattern(OBJECT_SELF,"ALPHA2",94);
    //SetListenPattern(OBJECT_SELF,"signal event **",95);
    //SetListenPattern(OBJECT_SELF,"cheat stick",96);
    //SetListenPattern(OBJECT_SELF,"Toggle Adjustment",97);
    //SetListenPattern(OBJECT_SELF,"item **",98);
    //SetListenPattern(OBJECT_SELF,"journal **",99);


    SetIsDestroyable(FALSE, TRUE, TRUE);

    // Set additional henchman listening patterns
    //bkSetListeningPatterns();

    // Default behavior for henchmen at start
    SetAssociateState(NW_ASC_POWER_CASTING);
    SetAssociateState(NW_ASC_HEAL_AT_50);
    SetAssociateState(NW_ASC_RETRY_OPEN_LOCKS, TRUE);
    SetAssociateState(NW_ASC_DISARM_TRAPS, TRUE);

    // * July 2003. Set this to true so henchmen
    // * will hopefully run off a little less often
    // * by default
    // * September 2003. Bad decision. Reverted back
    // * to original. This mode too often looks like a bug
    // * because they hang back and don't help each other out.
    //SetAssociateState(NW_ASC_MODE_DEFEND_MASTER, TRUE);
    SetAssociateState(NW_ASC_DISTANCE_2_METERS);

    //Use melee weapons by default
    SetAssociateState(NW_ASC_USE_RANGED_WEAPON, FALSE);

    // For some general behavior while we don't have a master,
    // let's do some immobile animations
    SetSpawnInCondition(NW_FLAG_IMMOBILE_AMBIENT_ANIMATIONS);

        //SetAssociateState(NW_ASC_MODE_DEFEND_MASTER);
    //SetAssociateStartLocation();
    // SPECIAL CONVERSATION SETTTINGS
    //SetSpawnInCondition(NW_FLAG_SPECIAL_CONVERSATION);
    //SetSpawnInCondition(NW_FLAG_SPECIAL_COMBAT_CONVERSATION);
            // This causes the creature to say a special greeting in their conversation file
            // upon Perceiving the player. Attach the [NW_D2_GenCheck.nss] script to the desired
            // greeting in order to designate it. As the creature is actually saying this to
            // himself, don't attach any player responses to the greeting.


// CUSTOM USER DEFINED EVENTS
/*
    The following settings will allow the user to fire one of the blank user defined events in the NW_D2_DefaultD.  Like the
    On Spawn In script this script is meant to be customized by the end user to allow for unique behaviors.  The user defined
    events user 1000 - 1010
*/
    //SetSpawnInCondition(NW_FLAG_PERCIEVE_EVENT);         //OPTIONAL BEHAVIOR - Fire User Defined Event 1002
    //SetSpawnInCondition(NW_FLAG_ATTACK_EVENT);           //OPTIONAL BEHAVIOR - Fire User Defined Event 1005
    //SetSpawnInCondition(NW_FLAG_DAMAGED_EVENT);          //OPTIONAL BEHAVIOR - Fire User Defined Event 1006
    //SetSpawnInCondition(NW_FLAG_DISTURBED_EVENT);        //OPTIONAL BEHAVIOR - Fire User Defined Event 1008
    //SetSpawnInCondition(NW_FLAG_END_COMBAT_ROUND_EVENT); //OPTIONAL BEHAVIOR - Fire User Defined Event 1003
    SetSpawnInCondition(NW_FLAG_ON_DIALOGUE_EVENT);      //OPTIONAL BEHAVIOR - Fire User Defined Event 1004
    //SetSpawnInCondition(NW_FLAG_DEATH_EVENT);            //OPTIONAL BEHAVIOR - Fire User Defined Event 1007
    //SetIsDestroyable(FALSE,TRUE,TRUE);
}


