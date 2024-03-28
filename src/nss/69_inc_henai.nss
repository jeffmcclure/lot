//::///////////////////////////////////////////////
//:: 69_inc_HENAI
//:: Copyright (c) 2001 Bioware Corp.
//:: Modified: 69MEH69 21JUN2003
//:://////////////////////////////////////////////
/*
    This is a wrapper overtop of the 'generic AI'
    system with custom behavior for Henchmen.

    BENEFIT:
    - easier to isolate henchmen behavior
    - easier to debug COMBAT-AI because the
    advanced Henchmen behaviour won't be in those scripts

    CONS:
    - code duplicate. The two 'combat round' functions
    will share a lot of code because the old-AI still has
    to allow any legacy henchmen to work.


    NEW RADIALS/COMMANDS:
  - Open Inventory    "inventory"
  - Open Everything
  - Remove Traps [even nonthiefs will walk to detected traps]
  - NEVER FIGHT mode (or ALWAYS RETREAT) ; SetLocal; Implementation Code inside of DetermineCombatRound  DONE


    -=-=-=-=-=-=-
    MODIFICATIONS
    -=-=-=-=-=-=-



    // * BK Feb 6 2003
    // * Put a check in so that when a henchmen who cannot disarm a trap
    // * sees a trap they do not repeat their voiceover forever


*/
//:://////////////////////////////////////////////
//:: Created By:
//:: Created On:
//:://////////////////////////////////////////////

// #include "nw_i0_generic"  //...and through this also x0_inc_generic
#include "69_battlecries"
#include "69_i0_henchman"
// ****************************
// CONSTANTS
// ****************************

// ~ Behavior Constants
int BK_HEALINMELEE = 10;
int BK_CURRENT_AI_MODE = 20; // Can only be in one AI mode at a time
int BK_AI_MODE_FOLLOW = 9; // default mode, moving after the player
int BK_AI_MODE_RUN_AWAY = 19; // something is causing AI to retreat
int BK_NEVERFIGHT = 30;


// ~ Distance Constants
float BK_HEALTHRESHOLD = 5.0;
float BK_FOLLOW_THRESHOLD= 15.0;

// difficulty difference at which familiar will flee
//int BK_FAMILIAR_COWARD = 7;


/**********************************************************************
 * FUNCTION PROTOTYPES
 **********************************************************************/
// * Sets up special additional listening patterns
// * for associates.
void bkSetListeningPatterns();

// * Henchman/associate combat round wrapper
// * passing in OBJECT_INVALID is okay
// * Does special stuff for henchmen and familiars, then
// * falls back to default generic combat code.
void HenchmenCombatRound(object oIntruder=OBJECT_INVALID);

// * Attempt to disarm given trap
// * (called from RespondToShout and heartbeat)
int bkAttemptToDisarmTrap(object oTrap, int bWasShout = FALSE);

// * Attempt to open a given locked object.
int bkAttemptToOpenLock(object oLocked);

// Manually pick the nearest locked object
int bkManualPickNearestLock();

// Handles responses to henchmen commands, including both radial
// menu and voice commands.
void bkRespondToHenchmenShout(object oShouter, int nShoutIndex, object oIntruder = OBJECT_INVALID, int nBanInventory=FALSE);

//69MEH69: Returns TRUE if an item is found in inventory
// by BASE_ITEM_*
int mhGetItemByType(int nItemNum);

//69MEH69: Returns TRUE if there is any associate for oMaster
int mhGetAssociate(object oMaster = OBJECT_SELF);

//69MEH69: Equips melee weapon against oEnemy, considers dual-wielding
//void mhEquipMelee(object oEnemy, object oHench = OBJECT_SELF);

// * Attempt to heal self then master
int bkCombatAttemptHeal();

// * Attempts to follow master if outside range
int bkCombatFollowMaster();

// * set behavior used by AI
void bkSetBehavior(int nBehavior, int nValue);

// * get behavior used by AI
int bkGetBehavior(int nBehavior);

// ****LINEOFSIGHT*****

// * TRUE if the target door is in line of sight.
int bkGetIsDoorInLineOfSight(object oTarget);

// Get the cosine of the angle between two objects.
float bkGetCosAngleBetween(object Loc1, object Loc2);

// TRUE if target in the line of sight of the seer.
int bkGetIsInLineOfSight(object oTarget, object oSeer=OBJECT_SELF);


/**********************************************************************
 * FUNCTION DEFINITIONS
 **********************************************************************/

// * Sets up any special listening patterns in addition to the default
// * associate ones that are used
void bkSetListeningPatterns()
{

    SetListening(OBJECT_SELF, TRUE);
    SetListenPattern(OBJECT_SELF, "inventory",101);
    SetListenPattern(OBJECT_SELF, "pick",102);
    SetListenPattern(OBJECT_SELF, "trap", 103);
}

void mhEquipMelee(object oEnemy, object oHench = OBJECT_SELF)
{
     if(GetHasFeat(FEAT_TWO_WEAPON_FIGHTING, oHench))
     {
       ActionEquipMostDamagingMelee(oEnemy, TRUE);
       SetAssociateState(NW_ASC_USE_RANGED_WEAPON, FALSE);
       return;
     }
     else
     {
      ActionEquipMostDamagingMelee(oEnemy, FALSE);
      SetAssociateState(NW_ASC_USE_RANGED_WEAPON, FALSE);
      return;
     }

}

// Special combat round precursor for associates
void HenchmenCombatRound(object oIntruder)
{
    object oPC = GetFirstPC();
    //SpawnScriptDebugger();
    // * If someone has surrendered, then don't attack them.
    // * feb 25 2003
    if (GetIsObjectValid(oIntruder) == TRUE)
    {

        //object oEnemy = GetNearestEnemy();
        object oEnemy = GetNearestCreature(CREATURE_TYPE_REPUTATION,
                                               REPUTATION_TYPE_ENEMY,
                                               OBJECT_SELF, 1,
                                               CREATURE_TYPE_PERCEPTION,
                                               PERCEPTION_SEEN);
        float fEnemy = GetDistanceBetween(OBJECT_SELF, oEnemy);
        float fRanged = GetLocalFloat(OBJECT_SELF, "HenchRange");
        //Testing

        //string sName = GetName(OBJECT_SELF);
        //string sEnemy = FloatToString(fEnemy);
        //string sDiff = FloatToString(fEnemy - fRanged);
        //SendMessageToPC(oPC, "The enemy is " +sEnemy+ " meters from " +sName);
        //SendMessageToPC(oPC, "The difference is " +sDiff);
        //End Testing
        if(IsOutOfAmmo(FALSE) == TRUE)
        {
          //ClearAllActions();
          ActionEquipMostDamagingMelee(oEnemy, TRUE);
          ActionEquipMostDamagingMelee(oEnemy, TRUE);
          SetAssociateState(NW_ASC_USE_RANGED_WEAPON, FALSE);
        }
        if(!GetAssociateState(NW_ASC_USE_RANGED_WEAPON))
        {
         if(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, OBJECT_SELF) == OBJECT_INVALID)
         {
          //ClearAllActions(TRUE);
          if(GetHasFeat(FEAT_SHIELD_PROFICIENCY, OBJECT_SELF))
          {
           //bkEquipMelee(oEnemy, FALSE);
           ActionEquipMostDamagingMelee(oEnemy, FALSE);
           ActionEquipMostDamagingMelee(oEnemy, FALSE);
           SetAssociateState(NW_ASC_USE_RANGED_WEAPON, FALSE);
          }
          else
          {
           //bkEquipMelee(oEnemy, FALSE);
           ActionEquipMostDamagingMelee(oEnemy, FALSE);
           ActionEquipMostDamagingMelee(oEnemy, FALSE);
           SetAssociateState(NW_ASC_USE_RANGED_WEAPON, FALSE);
           //SendMessageToPC(oPC, "Equipped Melee");
           //mhEquipMelee(oEnemy, OBJECT_SELF);
          }
         }
        }
        else if(GetAssociateState(NW_ASC_USE_RANGED_WEAPON))
        {
         if((fEnemy - fRanged) <= 0.0 && fRanged != 100.0)
         {
          //ClearAllActions();
          //bkEquipMelee(oEnemy, FALSE);
          ActionEquipMostDamagingMelee(oEnemy, FALSE);
          ActionEquipMostDamagingMelee(oEnemy, FALSE);

         }
         else if((fEnemy - fRanged) > 0.0 && fRanged != 100.0)
         {
           //ClearAllActions();
           ActionEquipMostDamagingRanged(oEnemy);
           ActionEquipMostDamagingRanged(oEnemy);
           SetAssociateState(NW_ASC_USE_RANGED_WEAPON, TRUE);
         }
         if(fEnemy < 10.0 && fRanged == 100.0)
         {
            //ClearAllActions(TRUE);
            ActionMoveAwayFromObject(oEnemy, TRUE, 10.0);
            ActionMoveAwayFromObject(oEnemy, TRUE, 10.0);
            ActionEquipMostDamagingRanged(oEnemy);
            ActionEquipMostDamagingRanged(oEnemy);
            SetAssociateState(NW_ASC_USE_RANGED_WEAPON, TRUE);
         }
        }

    }
    if (GetIsEnemy(oIntruder) == FALSE)
    {
       //SendMessageToPC(oPC, "No enemy");
       ClearActions(999, TRUE);
       ActionAttack(OBJECT_INVALID);
       return;
    }
    //SpeakString("in combat round. Is an enemy");
    // * This is the nearest enemy
    object oNearestTarget = GetNearestCreature(CREATURE_TYPE_REPUTATION,
                                               REPUTATION_TYPE_ENEMY,
                                               OBJECT_SELF, 1,
                                               CREATURE_TYPE_PERCEPTION,
                                               PERCEPTION_SEEN);

    //    SpeakString("Henchman combat dude");

    // ****************************************
    // SETUP AND SANITY CHECKS (Quick Returns)
    // ****************************************

    // * BK: stop fighting if something bizarre that shouldn't happen, happens
    if (bkEvaluationSanityCheck(oIntruder, GetFollowDistance()) == TRUE) return;

    if(GetAssociateState(NW_ASC_IS_BUSY) || GetAssociateState(NW_ASC_MODE_DYING)) {
        return;
    }

    // MODIFIED FEBRUARY 13 2003
    // The associate will not engage in battle if in Stand Ground mode unless
    // he takes damage
    if((GetAssociateState(NW_ASC_MODE_STAND_GROUND) == TRUE && GetIsObjectValid(GetLastHostileActor()) == FALSE) || !GetLocalInt(OBJECT_SELF, MH_MODE_ATTACK))
    {
        return;
    }

    if(BashDoorCheck(oIntruder)) {return;}

    // ** Store how difficult the combat is for this round
    int nDiff = GetCombatDifficulty();
    SetLocalInt(OBJECT_SELF, "NW_L_COMBATDIFF", nDiff);

    object oMaster = GetMaster();
    int iHaveMaster = GetIsObjectValid(oMaster);

    // * Do henchmen specific things if I am a henchman otherwise run default AI
    if (iHaveMaster == TRUE) {

        // *******************************************
        // Healing
        // *******************************************
        // The FIRST PRIORITY: self-preservation
        // The SECOND PRIORITY: heal master;
        if (bkCombatAttemptHeal() == TRUE)
            return;

        // NEXT priority: follow or return to master for up to three rounds.
        if (bkCombatFollowMaster() == TRUE)
            return;

        //5. This check is to see if the master is being attacked and in need of help
        if(GetAssociateState(NW_ASC_MODE_DEFEND_MASTER))
        {
            oIntruder = GetLastHostileActor(GetRealMaster());
            if(!GetIsObjectValid(oIntruder))
            {
                //oIntruder = GetGoingToBeAttackedBy(GetMaster());

                // MODIFIED Major change. Defend is now Defend only if I attack
                // February 11 2003



                object oSelf = OBJECT_SELF;
                oIntruder = GetAttackTarget(GetRealMaster());
                // * February 11 2003
                // * means that the player was invovled in a battle
                if (GetIsObjectValid(oIntruder) || GetLocalInt(oSelf, "X0_BATTLEJOINEDMASTER") == TRUE)
                {

                    SetLocalInt(oSelf, "X0_BATTLEJOINEDMASTER", TRUE);
                    // * This is turned back to false whenever he hits the end of combat
                    if (GetIsObjectValid(oIntruder) == FALSE)
                    {
                        oIntruder = oNearestTarget;
                        if (GetIsObjectValid(oIntruder) == FALSE)
                        {
                            //* turn off the "I am in battle" sub-mode
                            SetLocalInt(oSelf, "X0_BATTLEJOINEDMASTER", FALSE);
                        }
                    }
                }
                // * Exit out and do nothing this combat round
                else
                {

                        return;
                }

            }
        }

        int iAmHenchman = (GetHenchman(oMaster) == OBJECT_SELF);
        if (iAmHenchman)
        {
            // 5% chance per round of speaking the relative challenge of the encounter.
            if (d100() > 95) {
                if (nDiff <= 1) VoiceLaugh(TRUE);
             // MODIFIED February 7 2003. This was confusing testing
             //   else if (nDiff <= 4) VoiceThreaten(TRUE);
             //   else VoiceBadIdea();
            }
        } // is a henchman

        // I am a familiar FLEE if tough
        /*
        MODIFIED FEB10 2003. Q/A hated this.

        int iAmFamiliar = (GetAssociate(ASSOCIATE_TYPE_FAMILIAR,oMaster) == OBJECT_SELF);
        if (iAmFamiliar) {
            // Run away from tough enemies
            if (nDiff >= BK_FAMILIAR_COWARD || GetPercentageHPLoss(OBJECT_SELF) < 40) {
                VoiceFlee();

                ClearActions(CLEAR_X0_INC_HENAI_HCR);
                ActionMoveAwayFromObject(oNearestTarget, TRUE, 40.0);
                return;
            }
        }
        */
     } // * is an associate

    // Fall through to generic combat

    // * only go into determinecombatround if there's a valid enemy nearby
    // * feb 26 2003: To prevent henchmen from resuming combat
    if (GetIsObjectValid(oIntruder) || GetIsObjectValid(oNearestTarget))
    {
        DetermineCombatRound(oIntruder);
    }
}


// Manually pick the nearest locked object
int bkManualPickNearestLock()
{
    object oLastObject = GetLockedObject(GetMaster());

    MyPrintString("Attempting to unlock: " + GetTag(oLastObject));

    return bkAttemptToOpenLock(oLastObject);
}

// * attempts to disarm last trap (called from RespondToShout and heartbeat
int bkAttemptToDisarmTrap(object oTrap, int bWasShout = FALSE)
{   //SpawnScriptDebugger();

    MyPrintString("Attempting to disarm: " + GetTag(oTrap));
    // SpawnScriptDebugger();
    // * May 2003: Don't try to disarm a trap with no trap
    if (GetIsTrapped(oTrap) == FALSE)
    {
        return FALSE;
    }
    if(!GetIsObjectValid(oTrap)
       || !GetTrapDetectedBy(oTrap, OBJECT_SELF)
       || GetDistanceToObject(oTrap) >= 15.0
       || !bkGetIsInLineOfSight(oTrap))
    {
        MyPrintString("Failed basic disarm check");
        if (bWasShout == TRUE)
            VoiceCannotDo();
        if(!IsInConversation(OBJECT_SELF))
        {
         SpeakString("Cannot disarm this trap.", TALKVOLUME_TALK);
        }
        return FALSE;
    }

    object oTrapSaved = GetLocalObject(OBJECT_SELF, "NW_ASSOCIATES_LAST_TRAP");
    SetLocalObject(OBJECT_SELF, "NW_ASSOCIATES_LAST_TRAP", oTrap);
    // We can tell we can't do it
        string sID = ObjectToString(oTrap);
    int nSkill = GetSkillRank(SKILL_DISABLE_TRAP);
    int nTrapDC = GetTrapDisarmDC(oTrap);
    if ( nSkill > 0 && (nSkill  + 20) >= nTrapDC && GetTrapDisarmable(oTrap)) {
        ClearActions(CLEAR_X0_INC_HENAI_AttemptToDisarmTrap);
        ActionUseSkill(SKILL_DISABLE_TRAP, oTrap);
        ActionDoCommand(SetCommandable(TRUE));
        ActionDoCommand(VoiceTaskComplete());
        if(!IsInConversation(OBJECT_SELF))
        {
         SpeakString("Trap Disarmed.", TALKVOLUME_TALK);
        }
        SetCommandable(FALSE);
        return TRUE;
    } else if (GetHasSpell(SPELL_FIND_TRAPS) && GetTrapDisarmable(oTrap) && GetLocalInt(oTrap, "NW_L_IATTEMPTEDTODISARMNOWORK") ==0)
    {
       // SpeakString("casting");
        ClearActions(CLEAR_X0_INC_HENAI_AttemptToDisarmTrap);
        ActionCastSpellAtObject(SPELL_FIND_TRAPS, oTrap);
        SetLocalInt(oTrap, "NW_L_IATTEMPTEDTODISARMNOWORK", 10);
        return TRUE;
    }
    // MODIFIED February 7 2003. Merged the 'attack object' inside of the bshout
    // this is not really something you want the henchmen just to go and do
    // spontaneously
    else if (bWasShout)
    {
        ClearActions(CLEAR_X0_INC_HENAI_BKATTEMPTTODISARMTRAP_ThrowSelfOnTrap);

        //SpeakStringByStrRef(40551); // * Out of game indicator that this trap can never be disarmed by henchman.
        if  (GetLocalInt(OBJECT_SELF, "X0_L_SAWTHISTRAPALREADY" + sID) != 10)
        {
            string sSpeak = GetStringByStrRef(40551);
            SendMessageToPC(GetMaster(), sSpeak);
            SetLocalInt(OBJECT_SELF, "X0_L_SAWTHISTRAPALREADY" + sID, 10);
        }
        if (GetObjectType(oTrap) != OBJECT_TYPE_TRIGGER)
        {
            // * because Henchmen are not allowed to switch weapons without the player's
            // * say this needs to be removed
            // it's an object we can destroy ranged
            ActionEquipMostDamagingRanged(oTrap); //Replaced 69MEH69
            ActionAttack(oTrap);
            SetLocalObject(OBJECT_SELF, "NW_GENERIC_DOOR_TO_BASH", oTrap);
            return TRUE;
        }
        bkManualPickNearestLock();
        // Throw ourselves on it nobly! :-) Yeah Right! 69MEH69 21JUN2003
        //ActionMoveToLocation(GetLocation(oTrap));
        //SetFacingPoint(GetPositionFromLocation(GetLocation(oTrap)));
        //ActionRandomWalk();
        return TRUE;
    }
    else if (nSkill > 0)
    {

        // * BK Feb 6 2003
        // * Put a check in so that when a henchmen who cannot disarm a trap
        // * sees a trap they do not repeat their voiceover forever
        if  (GetLocalInt(OBJECT_SELF, "X0_L_SAWTHISTRAPALREADY" + sID) != 10)
        {
            VoiceCannotDo();
            SetLocalInt(OBJECT_SELF, "X0_L_SAWTHISTRAPALREADY" + sID, 10);
           string sSpeak = GetStringByStrRef(40551);
           SendMessageToPC(GetMaster(), sSpeak);
        }

        return FALSE;
    }

    return FALSE;
}
//* attempts to cast knock to open the door
int AttemptKnockSpell(object oLocked)
{
    // If that didn't work, let's try using a knock spell
    if (GetHasSpell(SPELL_KNOCK)
        && (GetIsDoorActionPossible(oLocked,
                                    DOOR_ACTION_KNOCK)
            || GetIsPlaceableObjectActionPossible(oLocked,
                                                  PLACEABLE_ACTION_KNOCK)))
    {
        if (bkGetIsDoorInLineOfSight(oLocked) == FALSE)
        {
            // For whatever reason, GetObjectSeen doesn't return seen doors.
            //if (GetObjectSeen(oLocked))
            {
                ClearActions(CLEAR_X0_INC_HENAI_AttemptToOpenLock2);
                VoiceCanDo();
                ActionWait(1.0);
                ActionCastSpellAtObject(SPELL_KNOCK, oLocked);
                ActionWait(1.0);
                return TRUE;
            }
        }

    }
    return FALSE;
}

// * Attempt to open a given locked object.
int bkAttemptToOpenLock(object oLocked)
{
   // SpawnScriptDebugger();
    if ( !GetIsObjectValid(oLocked)
         || GetLockKeyRequired(oLocked)
         || !bkGetIsInLineOfSight(oLocked) )
         //|| GetObjectSeen(oLocked) == FALSE) This check doesn't work.
         {
        // Can't open this, so skip the checks
        MyPrintString("Failed basic check");
        VoiceCannotDo();
        if(!IsInConversation(OBJECT_SELF))
        {
         SpeakString("Cannot open this lock.", TALKVOLUME_TALK);
        }
        return FALSE;
    }

    // We might be able to open this

    int bCanDo = FALSE;

    // First, let's see if we notice that it's trapped
    if (GetIsTrapped(oLocked) && GetTrapDetectedBy(oLocked, OBJECT_SELF))
    {
        // Ick! Try and disarm the trap first
        MyPrintString("Trap on it to disarm");
        if (! bkAttemptToDisarmTrap(oLocked))
        {
            // * Feb 11 2003. Attempt to cast knock because its
            // * always safe to cast it, even on a trapped object
            if (AttemptKnockSpell(oLocked) == TRUE)
            {
                return TRUE;
            }
            //VoicePicklock();
            VoiceNo();
            if(!IsInConversation(OBJECT_SELF))
            {
             SpeakString("No", TALKVOLUME_TALK);
            }
            return FALSE;
        }
    }

    // Now, let's try and pick the lock first
    int nSkill = GetSkillRank(SKILL_OPEN_LOCK);
    if (nSkill > 0) {
        nSkill += GetAbilityModifier(ABILITY_DEXTERITY);
        nSkill += 20;
    }

    if (nSkill > GetLockUnlockDC(oLocked)
        &&
        (GetIsDoorActionPossible(oLocked,
                                 DOOR_ACTION_UNLOCK)
         || GetIsPlaceableObjectActionPossible(oLocked,
                                               PLACEABLE_ACTION_UNLOCK))) {
        ClearActions(CLEAR_X0_INC_HENAI_AttemptToOpenLock1);
        VoiceCanDo();
        if(!IsInConversation(OBJECT_SELF))
        {
         SpeakString("Opening lock.", TALKVOLUME_TALK);
        }
        ActionWait(1.0);
        ActionUseSkill(SKILL_OPEN_LOCK,oLocked);
        ActionWait(1.0);
        bCanDo = TRUE;
    }

    if (!bCanDo)
        bCanDo = AttemptKnockSpell(oLocked);


    if (!bCanDo
        && GetAbilityScore(OBJECT_SELF, ABILITY_STRENGTH) >= 16
        && !GetPlotFlag(oLocked)
        && (GetIsDoorActionPossible(oLocked,
                                    DOOR_ACTION_BASH)
            || GetIsPlaceableObjectActionPossible(oLocked,
                                                  PLACEABLE_ACTION_BASH))) {
        ClearActions(CLEAR_X0_INC_HENAI_AttemptToOpenLock3);
        VoiceCanDo();
        ActionWait(1.0);

        // MODIFIED February 2003
        // Since the player has direct control over weapon, automatic equipping is frustrating.
        // removed.
        //        ActionEquipMostDamagingMelee(oLocked);
        ActionAttack(oLocked);
        SetLocalObject(OBJECT_SELF, "NW_GENERIC_DOOR_TO_BASH", oLocked);
        bCanDo = TRUE;
    }

    if (!bCanDo && !GetPlotFlag(oLocked) && GetHasSpell(SPELL_MAGIC_MISSILE))
    {
        ClearActions(CLEAR_X0_INC_HENAI_AttemptToOpenLock3);
        ActionCastSpellAtObject(SPELL_MAGIC_MISSILE,oLocked);
        return TRUE;
    }

    // If we did it, let the player know
    if(!bCanDo) {
        VoiceCannotDo();
        if(!IsInConversation(OBJECT_SELF))
        {
         SpeakString("Cannot do this.", TALKVOLUME_TALK);
        }
    } else {
        ActionDoCommand(VoiceTaskComplete());
        if(!IsInConversation(OBJECT_SELF))
        {
         DelayCommand(6.0, SpeakString("Done.", TALKVOLUME_TALK));
        }
        return TRUE;
    }

    return FALSE;
}


// Handles responses to henchmen commands, including both radial
// menu and voice commands.
void bkRespondToHenchmenShout(object oShouter, int nShoutIndex, object oIntruder, int nBanInventory=FALSE) // = OBJECT_INVALID
{

    // * if petrified, jump out
    if (GetHasEffect(EFFECT_TYPE_PETRIFY, OBJECT_SELF) == TRUE)
    {
        return;
    }

    // * MODIFIED February 19 2003
    // * Do not respond to shouts if in dying mode
    if (GetIsHenchmanDying() == TRUE)
    {
        return;
    }

    // Do not respond to shouts if you've surrendered.
    int iSurrendered = GetLocalInt(OBJECT_SELF,"Generic_Surrender");
    if (iSurrendered)
    {
        return;
    }

    talent tUse;
    location lMaster;
    int nPickLock, nCurrent, nBase, nHench;
    object oLastObject;
    object oTrap;
    object oMaster;
    object oTarget, oLastAttacker, oldHench;
    object oHench, oFamiliar, oAnimal, oDominated, oSummoned;

    //ASSOCIATE SHOUT RESPONSES
    switch(nShoutIndex) {

    case ASSOCIATE_COMMAND_INVENTORY:
    {
        // feb 18. You are now allowed to access inventory during combat.
         if (nBanInventory == TRUE)
        {
            SpeakStringByStrRef(9066);
        }
        else
        {
            OpenInventory(OBJECT_SELF, GetRealMaster(OBJECT_SELF));
        }

        break;
        }

    case ASSOCIATE_COMMAND_PICKLOCK:
    {
        bkManualPickNearestLock();
        //69MEH69 Added for multiple henchmen command relay
        if(GetIsObjectValid(GetHenchman(OBJECT_SELF)) == TRUE)
        {
         oHench = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, OBJECT_SELF);
         AssignCommand(oHench, bkRespondToHenchmenShout(OBJECT_SELF, ASSOCIATE_COMMAND_PICKLOCK));
        }
        //69MEH69 end code
        break;
        }

    case ASSOCIATE_COMMAND_DISARMTRAP: // Disarm trap
    {
        bkAttemptToDisarmTrap(GetNearestTrapToObject(GetRealMaster()), TRUE);
        //69MEH69 Added for multiple henchmen command relay
        if(GetIsObjectValid(GetHenchman(OBJECT_SELF)) == TRUE)
        {
         oHench = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, OBJECT_SELF);
         AssignCommand(oHench, bkRespondToHenchmenShout(OBJECT_SELF, ASSOCIATE_COMMAND_DISARMTRAP));
        }
        //69MEH69 end code
        break;
        }

    case ASSOCIATE_COMMAND_ATTACKNEAREST:
    {
        ResetHenchmenState();
        SetLocalInt(OBJECT_SELF, MH_MODE_ATTACK, TRUE);
        SetAssociateState(NW_ASC_MODE_DEFEND_MASTER, FALSE);
        SetAssociateState(NW_ASC_MODE_STAND_GROUND, FALSE);
        HenchmenCombatRound(GetNearestSeenEnemy());

        // * bonus feature. If master is attacking a door or container, issues VWE Attack Nearest
        // * will make henchman join in on the fun
        oTarget = GetAttackTarget(OBJECT_SELF);
        if (GetIsObjectValid(oTarget) == TRUE)
        {
            if (GetObjectType(oTarget) == OBJECT_TYPE_PLACEABLE || GetObjectType(oTarget) == OBJECT_TYPE_DOOR)
            {
                ActionAttack(oTarget);
            }
        }
        //69MEH69 Added for multiple henchmen command relay
        if(GetIsObjectValid(GetHenchman(OBJECT_SELF)) == TRUE)
        {
         oHench = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, OBJECT_SELF);
         AssignCommand(oHench, bkRespondToHenchmenShout(OBJECT_SELF, ASSOCIATE_COMMAND_ATTACKNEAREST));
        }
        if(GetAssociate(ASSOCIATE_TYPE_FAMILIAR, OBJECT_SELF) != OBJECT_INVALID)
        {
         oFamiliar = GetAssociate(ASSOCIATE_TYPE_FAMILIAR, OBJECT_SELF);
         AssignCommand(oFamiliar, bkRespondToHenchmenShout(OBJECT_SELF, ASSOCIATE_COMMAND_ATTACKNEAREST));
        }
        if(GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, OBJECT_SELF) != OBJECT_INVALID)
        {
         oAnimal = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, OBJECT_SELF);
         AssignCommand(oAnimal, bkRespondToHenchmenShout(OBJECT_SELF, ASSOCIATE_COMMAND_ATTACKNEAREST));
        }
        if(GetAssociate(ASSOCIATE_TYPE_SUMMONED, OBJECT_SELF) != OBJECT_INVALID)
        {
         oSummoned = GetAssociate(ASSOCIATE_TYPE_SUMMONED, OBJECT_SELF);
         AssignCommand(oSummoned, bkRespondToHenchmenShout(OBJECT_SELF, ASSOCIATE_COMMAND_ATTACKNEAREST));
        }
        if(GetAssociate(ASSOCIATE_TYPE_DOMINATED, OBJECT_SELF) != OBJECT_INVALID)
        {
         oDominated = GetAssociate(ASSOCIATE_TYPE_DOMINATED, OBJECT_SELF);
         AssignCommand(oDominated, bkRespondToHenchmenShout(OBJECT_SELF, ASSOCIATE_COMMAND_ATTACKNEAREST));
        }
        //69MEH69 code end
        break;
        }

    case ASSOCIATE_COMMAND_FOLLOWMASTER:
    {
        ClearAllActions(TRUE);
        ResetHenchmenState();
        SetLocalInt(OBJECT_SELF, MH_MODE_ATTACK, FALSE);
        SetAssociateState(NW_ASC_MODE_STAND_GROUND, FALSE);
        SetLocalInt(OBJECT_SELF,"Scouting",FALSE);
        DelayCommand(2.5, VoiceCanDo());
        if(!IsInConversation(OBJECT_SELF))
        {
         HenchmanTalk(ASSOCIATE_COMMAND_FOLLOWMASTER);
         //SpeakString("Coming.", TALKVOLUME_TALK);
        }
        lMaster = GetBehindLocation(GetRealMaster());
        ActionForceMoveToLocation(lMaster, TRUE, 8.0);
        //UseStealthMode();
        //UseDetectMode();
        ActionForceFollowObject(GetMaster(), GetFollowDistance());
        SetAssociateState(NW_ASC_IS_BUSY);
        DelayCommand(5.0, SetAssociateState(NW_ASC_IS_BUSY, FALSE));
        DelayCommand(5.1, ActionForceMoveToLocation(lMaster, TRUE, 8.0));
        //69MEH69 Added for multiple henchmen command relay
       if(GetIsObjectValid(GetHenchman(OBJECT_SELF)) == TRUE)
        {
         oHench = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, OBJECT_SELF);
         AssignCommand(oHench, bkRespondToHenchmenShout(OBJECT_SELF, ASSOCIATE_COMMAND_FOLLOWMASTER));
        }
        if(GetAssociate(ASSOCIATE_TYPE_FAMILIAR, OBJECT_SELF) != OBJECT_INVALID)
        {
         oFamiliar = GetAssociate(ASSOCIATE_TYPE_FAMILIAR, OBJECT_SELF);
         AssignCommand(oFamiliar, bkRespondToHenchmenShout(OBJECT_SELF, ASSOCIATE_COMMAND_FOLLOWMASTER));
        }
        if(GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, OBJECT_SELF) != OBJECT_INVALID)
        {
         oAnimal = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, OBJECT_SELF);
         AssignCommand(oAnimal, bkRespondToHenchmenShout(OBJECT_SELF, ASSOCIATE_COMMAND_FOLLOWMASTER));
        }
        if(GetAssociate(ASSOCIATE_TYPE_SUMMONED, OBJECT_SELF) != OBJECT_INVALID)
        {
         oSummoned = GetAssociate(ASSOCIATE_TYPE_SUMMONED, OBJECT_SELF);
         AssignCommand(oSummoned, bkRespondToHenchmenShout(OBJECT_SELF, ASSOCIATE_COMMAND_FOLLOWMASTER));
        }
        if(GetAssociate(ASSOCIATE_TYPE_DOMINATED, OBJECT_SELF) != OBJECT_INVALID)
        {
         oDominated = GetAssociate(ASSOCIATE_TYPE_DOMINATED, OBJECT_SELF);
         AssignCommand(oDominated, bkRespondToHenchmenShout(OBJECT_SELF, ASSOCIATE_COMMAND_FOLLOWMASTER));
        }
        //69MEH69 code end
        break;
        }


    case ASSOCIATE_COMMAND_GUARDMASTER:
    {
         ResetHenchmenState();
        //DelayCommand(2.5, VoiceCannotDo());

        //Companions will only attack the Masters Last Attacker
        SetLocalInt(OBJECT_SELF, MH_MODE_ATTACK, TRUE);
        SetAssociateState(NW_ASC_MODE_DEFEND_MASTER);
        SetAssociateState(NW_ASC_MODE_STAND_GROUND, FALSE);
        oLastAttacker = GetLastHostileActor(GetRealMaster());
        // * for some reason this is too often invalid. still the routine
        // * works corrrectly
        SetLocalInt(OBJECT_SELF, "X0_BATTLEJOINEDMASTER", TRUE);
        HenchmenCombatRound(oLastAttacker);
        //69MEH69 Added for multiple henchmen command relay
        if(GetIsObjectValid(GetHenchman(OBJECT_SELF)) == TRUE)
        {
         oHench = GetHenchman(OBJECT_SELF);
         AssignCommand(oHench, bkRespondToHenchmenShout(OBJECT_SELF, ASSOCIATE_COMMAND_GUARDMASTER));
        }
        if(GetAssociate(ASSOCIATE_TYPE_FAMILIAR, OBJECT_SELF) != OBJECT_INVALID)
        {
         oFamiliar = GetAssociate(ASSOCIATE_TYPE_FAMILIAR, OBJECT_SELF);
         AssignCommand(oFamiliar, bkRespondToHenchmenShout(OBJECT_SELF, ASSOCIATE_COMMAND_GUARDMASTER));
        }
        if(GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, OBJECT_SELF) != OBJECT_INVALID)
        {
         oAnimal = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, OBJECT_SELF);
         AssignCommand(oAnimal, bkRespondToHenchmenShout(OBJECT_SELF, ASSOCIATE_COMMAND_GUARDMASTER));
        }
        if(GetAssociate(ASSOCIATE_TYPE_SUMMONED, OBJECT_SELF) != OBJECT_INVALID)
        {
         oSummoned = GetAssociate(ASSOCIATE_TYPE_SUMMONED, OBJECT_SELF);
         AssignCommand(oSummoned, bkRespondToHenchmenShout(OBJECT_SELF, ASSOCIATE_COMMAND_GUARDMASTER));
        }
        if(GetAssociate(ASSOCIATE_TYPE_DOMINATED, OBJECT_SELF) != OBJECT_INVALID)
        {
         oDominated = GetAssociate(ASSOCIATE_TYPE_DOMINATED, OBJECT_SELF);
         AssignCommand(oDominated, bkRespondToHenchmenShout(OBJECT_SELF, ASSOCIATE_COMMAND_GUARDMASTER));
        }
        //69MEH69 code end
        break;
        }

    case ASSOCIATE_COMMAND_HEALMASTER:
    {
        //Ignore current healing settings and heal me no
        // SpawnScriptDebugger();

        ResetHenchmenState();
        SetCommandable(TRUE, OBJECT_SELF);

        oTarget = GetFactionMostDamagedMember(OBJECT_SELF);
        if(GetIsObjectValid(oTarget))
        {
            if(GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD)
            {}
        nCurrent = GetCurrentHitPoints(oTarget);
        nBase = GetMaxHitPoints(oTarget);

        if(nCurrent < nBase && !GetIsDead(oTarget))
        {
            tUse = GetCreatureTalentBest(TALENT_CATEGORY_BENEFICIAL_HEALING_TOUCH, 20);
            if(GetIsTalentValid(tUse))
            {
                ClearAllActions();
                ActionUseTalentOnObject(tUse, oTarget);
            }
            else
            {
            AssignCommand(OBJECT_SELF, ActionSpeakString("I do not have any healing spells.", TALKVOLUME_TALK));
            }
        }
        }

        //69MEH69 Added for multiple henchmen command relay
        if(GetIsObjectValid(GetHenchman(OBJECT_SELF)) == TRUE)
        {
         oHench = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, OBJECT_SELF);
         AssignCommand(oHench, bkRespondToHenchmenShout(OBJECT_SELF, ASSOCIATE_COMMAND_HEALMASTER));
        }
        //69MEH69 code end
        break;
        }

    case ASSOCIATE_COMMAND_MASTERFAILEDLOCKPICK:
    {
        //Check local for re-try locked doors
        if(!GetAssociateState(NW_ASC_MODE_STAND_GROUND)
           && GetAssociateState(NW_ASC_RETRY_OPEN_LOCKS)) {
            oLastObject = GetLockedObject(GetRealMaster());
            bkAttemptToOpenLock(oLastObject);
        }
        //69MEH69 Added for multiple henchmen command relay
        if(GetIsObjectValid(GetHenchman(OBJECT_SELF)) == TRUE)
        {
         oHench = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, OBJECT_SELF);
         AssignCommand(oHench, bkRespondToHenchmenShout(OBJECT_SELF, ASSOCIATE_COMMAND_MASTERFAILEDLOCKPICK));
        }
        //69MEH69 code end
        break;
        }

    /*case ASSOCIATE_COMMAND_MASTERUNDERATTACK:
    {
        // Just go to henchman combat round
        HenchmenCombatRound();
        //69MEH69 Added for multiple henchmen command relay
        if(GetIsObjectValid(GetHenchman(OBJECT_SELF)) == TRUE)
        {
         oHench = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, OBJECT_SELF);
         AssignCommand(oHench, bkRespondToHenchmenShout(OBJECT_SELF, ASSOCIATE_COMMAND_MASTERUNDERATTACK));
        }
        //69MEH69 code end
        break;
        }*/

    case ASSOCIATE_COMMAND_STANDGROUND:
    {
        //No longer follow the master or guard him
        SetLocalInt(OBJECT_SELF, MH_MODE_ATTACK, FALSE);
        SetAssociateState(NW_ASC_MODE_STAND_GROUND);
        SetAssociateState(NW_ASC_MODE_DEFEND_MASTER, FALSE);
        DelayCommand(2.0, VoiceCanDo());
        ActionAttack(OBJECT_INVALID);
        ClearAllActions();
        //ClearActions(CLEAR_X0_INC_HENAI_RespondToShout1);
        //69MEH69 Added for multiple henchmen command relay
            if(GetIsObjectValid(GetHenchman(OBJECT_SELF)) == TRUE)
            {
              oHench = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, OBJECT_SELF);
              AssignCommand(oHench, bkRespondToHenchmenShout(OBJECT_SELF, ASSOCIATE_COMMAND_STANDGROUND));
            }
            if(GetAssociate(ASSOCIATE_TYPE_FAMILIAR, OBJECT_SELF) != OBJECT_INVALID)
            {
                oFamiliar = GetAssociate(ASSOCIATE_TYPE_FAMILIAR, OBJECT_SELF);
                AssignCommand(oFamiliar, bkRespondToHenchmenShout(OBJECT_SELF, ASSOCIATE_COMMAND_STANDGROUND));
            }
            if(GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, OBJECT_SELF) != OBJECT_INVALID)
            {
                oAnimal = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, OBJECT_SELF);
                AssignCommand(oAnimal, bkRespondToHenchmenShout(OBJECT_SELF, ASSOCIATE_COMMAND_STANDGROUND));
            }
            if(GetAssociate(ASSOCIATE_TYPE_SUMMONED, OBJECT_SELF) != OBJECT_INVALID)
            {
                oSummoned = GetAssociate(ASSOCIATE_TYPE_SUMMONED, OBJECT_SELF);
                AssignCommand(oSummoned, bkRespondToHenchmenShout(OBJECT_SELF, ASSOCIATE_COMMAND_STANDGROUND));
            }
            if(GetAssociate(ASSOCIATE_TYPE_DOMINATED, OBJECT_SELF) != OBJECT_INVALID)
            {
                oDominated = GetAssociate(ASSOCIATE_TYPE_DOMINATED, OBJECT_SELF);
                AssignCommand(oDominated, bkRespondToHenchmenShout(OBJECT_SELF, ASSOCIATE_COMMAND_STANDGROUND));
            }
        //69MEH69 end code

      break;
      }

    case ASSOCIATE_COMMAND_MASTERSAWTRAP:
    {
        if(!GetIsInCombat()) {
            if(!GetAssociateState(NW_ASC_MODE_STAND_GROUND) && GetAssociateState(NW_ASC_DISARM_TRAPS)) {
                oTrap = GetLastTrapDetected(GetRealMaster());
                bkAttemptToDisarmTrap(oTrap);
            }
        }
        //69MEH69 Added for multiple henchmen command relay
        if(GetIsObjectValid(GetHenchman(OBJECT_SELF)) == TRUE)
        {
         oHench = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, OBJECT_SELF);
         AssignCommand(oHench, bkRespondToHenchmenShout(OBJECT_SELF, ASSOCIATE_COMMAND_MASTERSAWTRAP));
        }
        //69MEH69 end code
        break;
        }

    case ASSOCIATE_COMMAND_MASTERATTACKEDOTHER:
    {
          if(!GetAssociateState(NW_ASC_MODE_STAND_GROUND)) {
            if(!GetAssociateState(NW_ASC_MODE_DEFEND_MASTER)) {
                if(!GetIsFighting(OBJECT_SELF)) {
                    SetLocalInt(OBJECT_SELF, MH_MODE_ATTACK, TRUE);
                    object oAttack = GetAttackTarget(GetMaster());
                    // April 2003: If my master can see the enemy, then I can too.
                    if(GetIsObjectValid(oAttack) && GetObjectSeen(oAttack, GetMaster()))
                    {
                        ClearActions(CLEAR_X0_INC_HENAI_RespondToShout2);
                        HenchmenCombatRound(oAttack);
                    }
                }
            }
        }
        break;
        }

    case ASSOCIATE_COMMAND_MASTERGOINGTOBEATTACKED:
    {
        if(!GetAssociateState(NW_ASC_MODE_STAND_GROUND) && GetLocalInt(OBJECT_SELF, MH_MODE_ATTACK))
        {     //  SpawnScriptDebugger();
            if(!GetIsFighting(OBJECT_SELF)) {
                object oAttacker = GetGoingToBeAttackedBy(GetRealMaster());
                // April 2003: If my master can see the enemy, then I can too.
                // Potential Side effect : Henchmen may run
                // to stupid places, trying to get an enemy
                if(GetIsObjectValid(oAttacker) && GetObjectSeen(oAttacker, GetRealMaster()))
                {
                   // SpeakString("Defending Master");
                    ClearActions(CLEAR_X0_INC_HENAI_RespondToShout3);
                    ActionMoveToObject(oAttacker, TRUE, 7.0);
                    HenchmenCombatRound(oAttacker);

                }
            }
        }
        break;
        }

    case ASSOCIATE_COMMAND_LEAVEPARTY://69MEH69 Replaced code
    {
        oMaster = GetMaster();
        if(GetIsObjectValid(oMaster))
        {
           ClearAllActions();
           SetLocalObject(OBJECT_SELF,"NW_L_FORMERMASTER", oMaster);
           RemoveHenchman(oMaster, OBJECT_SELF);
           nHench = GetLocalInt(oMaster, "nHench");
           SetLocalInt(oMaster, "nHench", nHench - 1);
           oldHench = GetHenchman(OBJECT_SELF);
           if (GetIsObjectValid(oldHench))
           {
             RemoveHenchman(OBJECT_SELF, oldHench);
             AddHenchman(oMaster, oldHench);
           }
         }
        break;
        }
   }
}

//::///////////////////////////////////////////////
//:: bkCombatAttemptHeal
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Attempt to heal self and then master
*/
//:://////////////////////////////////////////////
//:: Created By:
//:: Created On:
//:://////////////////////////////////////////////

int bkCombatAttemptHeal()
{
    // * if master is disabled then attempt to free master
    object oMaster = GetRealMaster();


    // *turn into a match function...
    if (MatchDoIHaveAMindAffectingSpellOnMe(oMaster)) {
        int nSpellToUse = -1;

        if (GetHasSpell(SPELL_DISPEL_MAGIC, OBJECT_SELF) ) {
            ClearActions(CLEAR_X0_INC_HENAI_CombatAttemptHeal1);
            ActionCastSpellAtLocation(SPELL_DISPEL_MAGIC, GetLocation(oMaster));
            return TRUE;
        }
    }

    int iHealMelee = TRUE;
    if (bkGetBehavior(BK_HEALINMELEE) == FALSE)
        iHealMelee = FALSE;


    object oNearestEnemy = GetNearestSeenEnemy();

    float fDistance = 0.0;
    if (GetIsObjectValid(oNearestEnemy)) {
        fDistance = GetDistanceToObject(oNearestEnemy);
    }

    int iHP = GetPercentageHPLoss(OBJECT_SELF);

    // if less than 10% hitpoints then pretend that I am allowed
    // to heal in melee. Things are getting desperate
    if (iHP < 10)
     iHealMelee = TRUE;

    int iAmFamiliar = (GetAssociate(ASSOCIATE_TYPE_FAMILIAR,oMaster) == OBJECT_SELF);

    // * must be out of Melee range or ALLOWED to heal in melee
    if (fDistance > BK_HEALTHRESHOLD || iHealMelee) {
        int iAmHenchman = (GetHenchman(oMaster) == OBJECT_SELF);
        int iAmCompanion = (GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION,oMaster) == OBJECT_SELF);
        int iAmSummoned = (GetAssociate(ASSOCIATE_TYPE_SUMMONED,oMaster) == OBJECT_SELF);

        // Condition for immediate self-healing
        // Hit-point at less than 50% and random chance
        if (iHP < 50) {
            // verbalize
            if (iAmHenchman || iAmFamiliar) {
                // * when hit points less than 10% will whine about
                // * being near death
                if (iHP < 10 && Random(5) == 0)
                    VoiceNearDeath();
            }

            // attempt healing
            if (d100() > iHP-20) {
                ClearActions(CLEAR_X0_INC_HENAI_CombatAttemptHeal2);
                if (TalentHealingSelf()) return TRUE;
                if (iAmHenchman || iAmFamiliar)
                    if (Random(100) > 80) VoiceHealMe();
            }
        }

        // ********************************
        // Heal master if needed.
        // ********************************

        if (GetAssociateHealMaster()) {
            if (TalentHeal())
                return TRUE;
            else
                return FALSE;
        }
    }

    // * No healing done, continue with combat round
    return FALSE;
}

//::///////////////////////////////////////////////
//:: bkGetBehavior
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Set/get functions for CONTROL PANEL behavior
*/
//:://////////////////////////////////////////////
//:: Created By:
//:: Created On:
//:://////////////////////////////////////////////

int bkGetBehavior(int nBehavior)
{
    return GetLocalInt(OBJECT_SELF, "NW_L_BEHAVIOR" + IntToString(nBehavior));
}

void bkSetBehavior(int nBehavior, int nValue)
{
    SetLocalInt(OBJECT_SELF, "NW_L_BEHAVIOR"+IntToString(nBehavior), nValue);
}

//::///////////////////////////////////////////////
//:: bkCombatFollowMaster
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Forces the henchman to follow the player.
    Will even do this in the middle of combat if the
    distance it too great
*/
//:://////////////////////////////////////////////
//:: Created By:
//:: Created On:
//:://////////////////////////////////////////////

int bkCombatFollowMaster()
{
    object oMaster = GetRealMaster();
    int iAmHenchman = (GetHenchman(oMaster) == OBJECT_SELF);
    int iAmFamiliar = (GetAssociate(ASSOCIATE_TYPE_FAMILIAR,oMaster) == OBJECT_SELF);

    if(bkGetBehavior(BK_CURRENT_AI_MODE) != BK_AI_MODE_RUN_AWAY)
    {
        // * double follow threshold if in combat (May 2003)
        if (GetIsInCombat(OBJECT_SELF) == TRUE)
        {
            BK_FOLLOW_THRESHOLD = BK_FOLLOW_THRESHOLD * 2.0;
        }
        if(GetDistanceToObject(oMaster) > BK_FOLLOW_THRESHOLD)
        {
            if(GetCurrentAction(oMaster) != ACTION_FOLLOW)
            {
                ClearActions(CLEAR_X0_INC_HENAI_CombatFollowMaster1);
                MyPrintString("*****EXIT on follow master.*******");
                ActionForceFollowObject(GetMaster(), GetFollowDistance());
                return TRUE;
            }
        }
    }


//       4. If in 'NEVER FIGHT' mode will not fight but should TELL the player
//      that they are in NEVER FIGHT mode
    if (bkGetBehavior(BK_NEVERFIGHT) == TRUE)
    {
//SpawnScriptDebugger();
    ClearActions(CLEAR_X0_INC_HENAI_CombatFollowMaster2);
//    ActionWait(6.0);
//    ActionDoCommand(DelayCommand(5.9, SetCommandable(TRUE)));
//    SetCommandable(FALSE);
        if (d10() > 7)
        {
            if (iAmHenchman || iAmFamiliar)
                VoiceLookHere();
        }
    return TRUE;
    }


    return FALSE;
}


//Pausanias: Is Object in the line of sight of the seer
int bkGetIsInLineOfSight(object oTarget,object oSeer=OBJECT_SELF)
{
    object oView = GetFirstObjectInShape(SHAPE_SPHERE,40.0,
                                         GetLocation(oSeer),
                                         TRUE, OBJECT_TYPE_ALL);
    while (GetIsObjectValid(oView)) {
        if (oView == oTarget)
            return TRUE;
        oView = GetNextObjectInShape(SHAPE_SPHERE, 40.0,
                                     GetLocation(oSeer),
                                     TRUE, OBJECT_TYPE_ALL);
    }
    return FALSE;
}

// Get the cosine of the angle between the two objects
float bkGetCosAngleBetween(object Loc1, object Loc2)
{
    vector v1 = GetPositionFromLocation(GetLocation(Loc1));
    vector v2 = GetPositionFromLocation(GetLocation(Loc2));
    vector v3 = GetPositionFromLocation(GetLocation(OBJECT_SELF));

    v1.x -= v3.x; v1.y -= v3.y; v1.z -= v3.z;
    v2.x -= v3.x; v2.y -= v3.y; v2.z -= v3.z;

    float dotproduct = v1.x*v2.x+v1.y*v2.y+v1.z*v2.z;

    return dotproduct/(VectorMagnitude(v1)*VectorMagnitude(v2));

}

//Pausanias: Is there a closed door in the line of sight.
// * is door in line of sight
int bkGetIsDoorInLineOfSight(object oTarget)
{
    float fMeDoorDist;

    object oView = GetFirstObjectInShape(SHAPE_SPHERE, 40.0,
                                         GetLocation(OBJECT_SELF),
                                         TRUE,OBJECT_TYPE_DOOR);

    float fMeTrapDist = GetDistanceBetween(oTarget,OBJECT_SELF);

    while (GetIsObjectValid(oView)) {
        fMeDoorDist = GetDistanceBetween(oView,OBJECT_SELF);
        //SpeakString("Trap3 : "+FloatToString(fMeTrapDist)+" "+FloatToString(fMeDoorDist));
        if (fMeDoorDist < fMeTrapDist && !GetIsTrapped(oView))
            if (GetIsDoorActionPossible(oView,DOOR_ACTION_OPEN) ||
                GetIsDoorActionPossible(oView,DOOR_ACTION_UNLOCK)) {
                float fAngle = bkGetCosAngleBetween(oView,oTarget);
                //SpeakString("Angle: "+FloatToString(fAngle));
                if (fAngle > 0.5) {
                    // if (d10() > 7)
                    // SpeakString("There's something fishy near that door...");
                    return TRUE;
                }
            }

        oView = GetNextObjectInShape(SHAPE_SPHERE,40.0,
                                     GetLocation(OBJECT_SELF),
                                     TRUE, OBJECT_TYPE_DOOR);
    }

    //SpeakString("No matches found");
    return FALSE;
}

//69MEH69 GetRealMaster Code
/*object GetRealMaster(object henchman=OBJECT_SELF)
{
    object master = GetMaster(henchman);
    if (GetIsObjectValid(master))
    {
        while (GetIsObjectValid(GetMaster(master)))
        {
            master = GetMaster(master);
        }
    }
    return master;
} */

//Returns TRUE if
int mhGetItemByType(int nItemNum)
{
 object oItem = GetFirstItemInInventory(OBJECT_SELF);
 int nItemType;
 while(oItem != OBJECT_INVALID)
 {
  nItemType = GetBaseItemType(oItem);
  if(nItemNum == nItemType)
  {
   return TRUE;
  }
  oItem = GetNextItemInInventory(OBJECT_SELF);
 }
 return FALSE;
}
//Returns TRUE if
int mhGetAssociate(object oMaster = OBJECT_SELF)
{
  int nAssociateType = ASSOCIATE_TYPE_HENCHMAN;
  int nAssociate;
  int nInt;
  for(nInt = 1; nInt < 6; nInt++)
  {
   switch(nAssociateType)
   {
    case ASSOCIATE_TYPE_HENCHMAN:
    {
     if(GetAssociate(ASSOCIATE_TYPE_HENCHMAN, OBJECT_SELF) != OBJECT_INVALID)
     {
        nAssociate = TRUE;
        break;
     }
     else
     {
        nAssociateType = ASSOCIATE_TYPE_FAMILIAR;
        break;
     }
    }

    case ASSOCIATE_TYPE_FAMILIAR:
    {
     if(GetAssociate(ASSOCIATE_TYPE_FAMILIAR, OBJECT_SELF) != OBJECT_INVALID)
     {
        nAssociate = TRUE;
        break;
     }
     else
     {
        nAssociateType = ASSOCIATE_TYPE_ANIMALCOMPANION;
        break;
     }
    }

    case ASSOCIATE_TYPE_ANIMALCOMPANION:
    {
     if(GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, OBJECT_SELF) != OBJECT_INVALID)
     {
        nAssociate = TRUE;
        break;
     }
     else
     {
        nAssociateType = ASSOCIATE_TYPE_SUMMONED;
        break;
     }
    }

    case ASSOCIATE_TYPE_SUMMONED:
    {
     if(GetAssociate(ASSOCIATE_TYPE_SUMMONED, OBJECT_SELF) != OBJECT_INVALID)
     {
        nAssociate = TRUE;
        break;
     }
     else
     {
        nAssociateType = ASSOCIATE_TYPE_DOMINATED;
        break;
     }
    }

    case ASSOCIATE_TYPE_DOMINATED:
    {
     if(GetAssociate(ASSOCIATE_TYPE_DOMINATED, OBJECT_SELF) != OBJECT_INVALID)
     {
        nAssociate = TRUE;
        break;
     }
     else
     {
        nAssociate = FALSE;
        break;
     }
    }
   }

    if(nAssociateType == ASSOCIATE_TYPE_HENCHMAN)
    {
     nAssociate = TRUE;
    }

  }
    return nAssociate;
}



//void main() {}
