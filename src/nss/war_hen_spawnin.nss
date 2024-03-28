//::///////////////////////////////////////////////
//:: Associate: On Spawn In
//:: 69_hen_spawnin
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Nov 19, 2001
//:://////////////////////////////////////////////

#include "69_inc_henai"

void main()
{
    //Sets up the starting Experience Points for the henchmen.
    //Do NOT change this from 0.
    SetLocalInt(OBJECT_SELF, "nHenchXP", 0);
    SetLocalInt(OBJECT_SELF, "level_up", 1);
    int iCount = 1;
    int iLevel = GetHitDice(OBJECT_SELF);
    int iXP = 1000;
    int iInc = 2;
    while (iLevel > iCount)
    {
      SetLocalInt(OBJECT_SELF, "nHenchXP", iXP);
      iXP = iInc * 1000 + iXP;
      SetLocalInt(OBJECT_SELF, "level_up", iCount);
      iCount++;
      iInc++;
    }

    //Sets up Henchman Level Up style.
    //Set to 0 to turn off and 1 to turn on.
    //Turning this on will allow henchmen to auto level up
    //useing Experience points instead of Leveling up as
    //the PC levels up.
    //NOTE: DO NOT use an any level up scripts for your
    //henchmen in the Module Properties if you enable this.
    SetLocalInt(OBJECT_SELF, "nXPLevelUp", 1);


    //Sets up the HENCH_LAG for this henchman,
    //Replace the 1 with any number the henchman lags(+)
    //or leads(-) in level. Save this script as something
    //else per this henchman. This allows multileveled
    //henchman
    //Minimum of -1,-2,-3... Maximum of 1,2,3... Same Level = 0
    SetLocalInt(OBJECT_SELF, "nHenchLag", 0);

    //Sets the INT_NUM_HENCHMEN variable which is the number
    //of henchmen a PC is allowed to have. Keep this value
    //the same with all your henchman spawn in scripts.
    //Minimum of 1, Maximum of whatever your cpu can handle
    SetLocalInt(OBJECT_SELF, "nNumHench", 8);

    //Sets the maximum level this particular henchman may level
    //Minimum of 1, Maximum of 20?
    SetLocalInt(OBJECT_SELF, "nHenchMax", 39);

    //Sets the distance from an enemy that the henchman will attack
    SetLocalFloat(OBJECT_SELF, "EnemyPerceived", 7.5);

    //Sets the distance from the enemy that the henchman will switch to melee weapons
    SetLocalFloat(OBJECT_SELF, "HenchRange", 4.3);

    //Sets the maximum distance that the henchman will move awy from the PC until
    //they begin to move back toward the PC. This will only trigger when NOT in
    //combat, during combat use the FollowMe radial command.
    SetLocalFloat(OBJECT_SELF, "HenchDistance", 6.0);

    //Sets up the special henchmen listening patterns
    SetAssociateListenPatterns();

    SetListeningPatterns();
   // Goes through and sets up which shouts the NPC will listen to.

   //  SetListenPattern(OBJECT_SELF,"Jarulf scout ahead",1);
   //  SetListenPattern(OBJECT_SELF,"Jarulf Scout ahead",1);
   //  SetListenPattern(OBJECT_SELF,"Jarulf scout Ahead",1);
   //  SetListenPattern(OBJECT_SELF,"Jarulf Scout Ahead",1);
   //  SetListenPattern(OBJECT_SELF,"jarulf scout ahead",1);
   //  SetListenPattern(OBJECT_SELF,"jarulf Scout ahead",1);
   //  SetListenPattern(OBJECT_SELF,"jarulf scout Ahead",1);
   //  SetListenPattern(OBJECT_SELF,"jarulf Scout Ahead",1);
   //
   // SetListenPattern(OBJECT_SELF,"disarm trap",2);
   // SetListenPattern(OBJECT_SELF,"Disarm Trap",2);
   // SetListenPattern(OBJECT_SELF,"Disarm trap",2);
   //
   // SetListenPattern(OBJECT_SELF,"open lock",3);
   // SetListenPattern(OBJECT_SELF,"Open Lock",3);
   // SetListenPattern(OBJECT_SELF,"Open lock",3);

   SetListenPattern(OBJECT_SELF,"Jarulf hide",4);
   SetListenPattern(OBJECT_SELF,"Jarulf Hide",4);
   SetListenPattern(OBJECT_SELF,"jarulf hide",4);
   SetListenPattern(OBJECT_SELF,"jarulf Hide",4);

   SetListenPattern(OBJECT_SELF,"hide",5);
   SetListenPattern(OBJECT_SELF,"Hide",5);

   SetListenPattern(OBJECT_SELF,"Jarulf arm melee",6);
   SetListenPattern(OBJECT_SELF,"Jarulf Arm melee",6);
   SetListenPattern(OBJECT_SELF,"Jarulf arm Melee",6);
   SetListenPattern(OBJECT_SELF,"Jarulf Arm Melee",6);
   SetListenPattern(OBJECT_SELF,"jarulf arm melee",6);
   SetListenPattern(OBJECT_SELF,"jarulf Arm melee",6);
   SetListenPattern(OBJECT_SELF,"jarulf arm Melee",6);
   SetListenPattern(OBJECT_SELF,"jarulf Arm Melee",6);

   SetListenPattern(OBJECT_SELF,"Jarulf arm ranged",7);
   SetListenPattern(OBJECT_SELF,"Jarulf Arm ranged",7);
   SetListenPattern(OBJECT_SELF,"Jarulf arm Ranged",7);
   SetListenPattern(OBJECT_SELF,"Jarulf Arm Ranged",7);
   SetListenPattern(OBJECT_SELF,"jarulf arm ranged",7);
   SetListenPattern(OBJECT_SELF,"jarulf Arm ranged",7);
   SetListenPattern(OBJECT_SELF,"jarulf arm Ranged",7);
   SetListenPattern(OBJECT_SELF,"jarulf Arm Ranged",7);

   SetListenPattern(OBJECT_SELF,"Jarulf come here",12);
   SetListenPattern(OBJECT_SELF,"Jarulf Come here",12);
   SetListenPattern(OBJECT_SELF,"Jarulf Come Here",12);
   SetListenPattern(OBJECT_SELF,"jarulf come here",12);
   SetListenPattern(OBJECT_SELF,"jarulf Come here",12);
   SetListenPattern(OBJECT_SELF,"jarulf Come Here",12);

   SetListenPattern(OBJECT_SELF,"come here",13);
   SetListenPattern(OBJECT_SELF,"Come here",13);
   SetListenPattern(OBJECT_SELF,"Come Here",13);

   //SetListenPattern(OBJECT_SELF,"talk to me",14);

   SetListenPattern(OBJECT_SELF,"Jarulf attack",14);
   SetListenPattern(OBJECT_SELF,"Jarulf Attack",14);
   SetListenPattern(OBJECT_SELF,"jarulf attack",14);
   SetListenPattern(OBJECT_SELF,"jarulf Attack",14);

   SetListenPattern(OBJECT_SELF,"attack",15);
   SetListenPattern(OBJECT_SELF,"Attack",15);

   //SetListenPattern(OBJECT_SELF,"cast **",16);
   //SetListenPattern(OBJECT_SELF,"Cast **",16);

   SetListenPattern(OBJECT_SELF,"Jarulf wait there",16);
   SetListenPattern(OBJECT_SELF,"Jarulf Wait there",16);
   SetListenPattern(OBJECT_SELF,"Jarulf Wait There",16);
   SetListenPattern(OBJECT_SELF,"jarulf wait there",16);
   SetListenPattern(OBJECT_SELF,"jarulf Wait there",16);
   SetListenPattern(OBJECT_SELF,"jarulf Wait There",16);

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

   SetListenPattern(OBJECT_SELF,"Jarulf fall back",20);
   SetListenPattern(OBJECT_SELF,"jarulf Fall back",20);
   SetListenPattern(OBJECT_SELF,"Jarulf Fall Back",20);
   SetListenPattern(OBJECT_SELF,"jarulf fall back",20);
   SetListenPattern(OBJECT_SELF,"jarulf Fall back",20);
   SetListenPattern(OBJECT_SELF,"jarulf Fall Back",20);

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
    bkSetListeningPatterns();

    SetAssociateState(NW_ASC_POWER_CASTING);
    SetAssociateState(NW_ASC_HEAL_AT_50);
    SetAssociateState(NW_ASC_RETRY_OPEN_LOCKS);
    SetAssociateState(NW_ASC_DISARM_TRAPS);
    SetAssociateState(NW_ASC_MODE_DEFEND_MASTER, FALSE);
    //Equips melee weapon by default
    //Equips ranged weapons by default if TRUE.
    SetAssociateState(NW_ASC_USE_RANGED_WEAPON, FALSE);
    //Sets the default distance that the henchman will follow
    //the PC, only uncomment one of the following three
    SetAssociateState(NW_ASC_DISTANCE_2_METERS);
    //SetAssociateState(NW_ASC_DISTANCE_4_METERS);
    //SetAssociateState(NW_ASC_DISTANCE_6_METERS);
    //End default distances
    //Sets the default that the henchman will attack the enemy
    SetLocalInt(OBJECT_SELF, MH_MODE_ATTACK, TRUE);

    // April 2002: Summoned monsters, associates and familiars need to stay
    // further back due to their size.
    if (GetAssociate(ASSOCIATE_TYPE_HENCHMAN, GetMaster()) == OBJECT_SELF  ||
        GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, GetMaster()) == OBJECT_SELF  ||
        GetAssociate(ASSOCIATE_TYPE_DOMINATED, GetMaster()) == OBJECT_SELF  ||
        GetAssociate(ASSOCIATE_TYPE_FAMILIAR, GetMaster()) == OBJECT_SELF  ||
        GetAssociate(ASSOCIATE_TYPE_SUMMONED, GetMaster()) == OBJECT_SELF)
    {
        SetAssociateState(NW_ASC_DISTANCE_4_METERS);
    }


    //SetAssociateState(NW_ASC_MODE_DEFEND_MASTER);
    SetAssociateStartLocation();
    // SPECIAL CONVERSATION SETTTINGS
    //SetSpawnInCondition(NW_FLAG_SPECIAL_CONVERSATION);
    //SetSpawnInCondition(NW_FLAG_SPECIAL_COMBAT_CONVERSATION);
            // This causes the creature to say a special greeting in their conversation file
            // upon Perceiving the player. Attach the [NW_D2_GenCheck.nss] script to the desired
            // greeting in order to designate it. As the creature is actually saying this to
            // himself, don't attach any player responses to the greeting.
    // Set respawn location
    SetRespawnLocation();

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
    //SetSpawnInCondition(NW_FLAG_ON_DIALOGUE_EVENT);      //OPTIONAL BEHAVIOR - Fire User Defined Event 1004
    //SetSpawnInCondition(NW_FLAG_DEATH_EVENT);            //OPTIONAL BEHAVIOR - Fire User Defined Event 1007

    //ExecuteScript("vcs_onspawn", OBJECT_SELF);
}

