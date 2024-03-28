#include "hench_i0_heal"
#include "hench_i0_spells"
#include "hench_i0_ai"
#include "hench_i0_act"


// Threshold challange rating for buff spells
const float PAUSANIAS_CHALLENGE_THRESHOLD = -2.0;
const float PAUSANIAS_FAMILIAR_THRESHOLD = -2.0;
const float PAUSANIAS_DISTANCE_THRESHOLD = 5.0;

const int HENCH_BLEAD_NEGHPS = -10;



void main()
{    
    object oIntruder = GetLocalObject(OBJECT_SELF, "AIIntruderObj");
    int bForce = GetLocalInt(OBJECT_SELF, "AIIntruderForce");    
        
    int curIntrudeCount = GetLocalInt(OBJECT_SELF, "AIIntruder");
    ++curIntrudeCount;
    SetLocalInt(OBJECT_SELF, "AIIntruder", curIntrudeCount);

//    Jug_Debug(GetName(OBJECT_SELF) + " starting det combat int = " + GetName(oIntruder) + " action " + IntToString(GetCurrentAction()));

    int iHP = GetPercentageHPLoss(OBJECT_SELF);
    int iCheckHealing = iHP < 50;
    SetLocalInt(OBJECT_SELF, "INeedHealing", iCheckHealing ? 2 : 1);

    int nCurAction = GetCurrentAction();

    // ----------------------------------------------------------------------------------------
    // Oct 06/2003 - Georg Zoeller,
    // Fix for ActionRandomWalk blocking the action queue under certain circumstances
    // ----------------------------------------------------------------------------------------
    if (nCurAction == ACTION_RANDOMWALK)
    {
        ClearAllActions();
    }

    // Auldar: Don't want anything to disturb the Taunt attempt.
    if(GetAssociateState(NW_ASC_IS_BUSY) || GetAssociateState(NW_ASC_MODE_DYING) || nCurAction == ACTION_TAUNT || nCurAction == ACTION_HEAL || nCurAction == ACTION_ANIMALEMPATHY)
    {
        DeleteLocalInt(OBJECT_SELF, "AIIntruder");
        return;
    }
    // MODIFIED FEBRUARY 13 2003
    // The associate will not engage in battle if in Stand Ground mode unless
    // he takes damage
    if(GetAssociateState(NW_ASC_MODE_STAND_GROUND) && !GetIsObjectValid(GetLastHostileActor()))
    {
        DeleteLocalInt(OBJECT_SELF, "AIIntruder");
        return;
    }
    
    int iEffectsOnSelf = 0;   
    
    effect eCheck = GetFirstEffect(OBJECT_SELF);
    while (GetIsEffectValid(eCheck))
    {
        switch(GetEffectType(eCheck))
        {
    // Pausanias: sanity check for various effects
        case EFFECT_TYPE_PARALYZE:
        case EFFECT_TYPE_STUNNED:
        case EFFECT_TYPE_FRIGHTENED:
        case EFFECT_TYPE_SLEEP:
        // TODO handle daze - can walk away
        case EFFECT_TYPE_DAZED:
        case EFFECT_TYPE_PETRIFY:
            DeleteLocalInt(OBJECT_SELF, "AIIntruder");
            DeleteLocalObject(OBJECT_SELF, "LastTarget");
            return;
        case EFFECT_TYPE_ETHEREAL:
            iEffectsOnSelf |= HENCH_HAS_ETHEREAL_EFFECT;
            break;
        case EFFECT_TYPE_CONCEALMENT:
            iEffectsOnSelf |= HENCH_HAS_CONCEALMENT_EFFECT;
            break;
        case EFFECT_TYPE_INVISIBILITY:
        case EFFECT_TYPE_IMPROVEDINVISIBILITY:
            iEffectsOnSelf |= HENCH_HAS_INVISIBILITY_EFFECT;
            break;
        case EFFECT_TYPE_SANCTUARY:
            iEffectsOnSelf |= HENCH_HAS_SANTUARY_EFFECT;
            break;
        case EFFECT_TYPE_CONFUSED:
            iEffectsOnSelf |= HENCH_HAS_CONFUSED_EFFECT;
            break;
        case EFFECT_TYPE_CHARMED:
            iEffectsOnSelf |= HENCH_HAS_CHARMED_EFFECT;
            break;
        case EFFECT_TYPE_POLYMORPH:
            iEffectsOnSelf |= HENCH_HAS_POLYMORPH_EFFECT;
            break;
        case EFFECT_TYPE_HASTE:
            iEffectsOnSelf |= HENCH_HAS_HASTE_EFFECT;
            break;
        case EFFECT_TYPE_TIMESTOP:
            iEffectsOnSelf |= HENCH_HAS_TIMESTOP_EFFECT;
            break;
        }
        eCheck = GetNextEffect(OBJECT_SELF);
    }
    
//    TODO removed due to problem with group buff
//  int iTime = GetTimeSecond() + 1;
    // Finish casting your spells if you've started.
    if (nCurAction == ACTION_CASTSPELL)
    {
        return;
        
/*        int iLast = GetLocalInt( OBJECT_SELF, "TimedSpellWait");
        if (iLast == 0)
        {
            SetLocalInt(OBJECT_SELF,"TimedSpellWait", iTime);
            return;
        }
        int iS = iTime < iLast ? iTime + 60 : iTime;
        // wait at most 6 seconds to complete spell
        if (iS - iLast < 6)
        {
            SetLocalInt(OBJECT_SELF,"TimedSpellWait", iS);
            return;
        } */
    }
//    SetLocalInt(OBJECT_SELF, "TimedSpellWait", 0);

    // reset action queue
    if (nCurAction != ACTION_INVALID)
    {
        ClearAllActions();
    }
    
    object oMaster = GetMaster();
    object oRealMaster = GetRealMaster();
    int iAmMonster = GetIsEnemy(GetFirstPC());
    int iHaveMaster = !iAmMonster && GetIsObjectValid(oMaster);

    int iAmHenchman,iAmFamiliar,iAmCompanion;
    if (iHaveMaster)
    {
        int nAssocType = GetAssociateType(OBJECT_SELF);
        iAmHenchman = nAssocType == ASSOCIATE_TYPE_HENCHMAN;
        iAmFamiliar = nAssocType == ASSOCIATE_TYPE_FAMILIAR;
        iAmCompanion = nAssocType == ASSOCIATE_TYPE_ANIMALCOMPANION;
    }
    
    // special code for Helmed Horror in Host Tower level 4
    if (GetTag(OBJECT_SELF) == "2Q6_HelmHorror")
    {
        oIntruder = GetNearestObjectByTag("2q6_sanctumgolem");
        if (!GetIsObjectValid(oIntruder))
        {
            ClearAllActions();
            DestroyObject(OBJECT_SELF);
            return;
        }
        ActionAttack(oIntruder);
        return;
    }

    object oClosestSeen;
    object oClosestHeard;
    object oClosestNonActive;
    object oClosestSummoned;
    
    int curCount = 1;
    while (TRUE)
    {
        oClosestSeen = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY,
                            OBJECT_SELF, curCount, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN,
                            CREATURE_TYPE_IS_ALIVE, TRUE);
        if (!GetIsObjectValid(oClosestSeen))
        {            
            break;                
        }
        if (GetPlotFlag(oClosestSeen))
        {
            // ignore plot creatures  
        }
        else if (GetLocalInt(oClosestSeen,"RunningAway") ||
            GetHasAnyEffect3(EFFECT_TYPE_PARALYZE, EFFECT_TYPE_STUNNED, EFFECT_TYPE_FRIGHTENED, oClosestSeen) ||
            GetHasAnyEffect3(EFFECT_TYPE_SLEEP, EFFECT_TYPE_DAZED, EFFECT_TYPE_PETRIFY, oClosestSeen))
        {
            if (!GetIsObjectValid(oClosestNonActive))
            {
                oClosestNonActive = oClosestSeen;
            }
        }
        else if (GetAbilityScore(OBJECT_SELF, ABILITY_INTELLIGENCE) > 9 && !GetIsObjectValid(oClosestSummoned) &&
            GetAssociateType(OBJECT_SELF) != ASSOCIATE_TYPE_HENCHMAN &&
            GetAssociateType(OBJECT_SELF) != ASSOCIATE_TYPE_NONE)
        {
            oClosestSummoned = oClosestSeen;         
        }
        // never consider dying henchman
        else if (!HenchGetAssociateState(NW_ASC_MODE_DYING, oClosestSeen))
        {
            break;
        }
        curCount++;
    }
    curCount = 1;    
    while (TRUE)
    {
        oClosestHeard = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY,
                            OBJECT_SELF, curCount, CREATURE_TYPE_PERCEPTION, PERCEPTION_HEARD_AND_NOT_SEEN,
                            CREATURE_TYPE_IS_ALIVE, TRUE);
        if (!GetIsObjectValid(oClosestHeard))
        {            
            break;                
        }
        if (GetPlotFlag(oClosestHeard))
        {
            // ignore plot creatures  
        }
        else if (GetLocalInt(oClosestHeard, "RunningAway") ||
            GetHasAnyEffect3(EFFECT_TYPE_PARALYZE, EFFECT_TYPE_STUNNED, EFFECT_TYPE_FRIGHTENED, oClosestHeard) ||
            GetHasAnyEffect3(EFFECT_TYPE_SLEEP, EFFECT_TYPE_DAZED, EFFECT_TYPE_PETRIFY, oClosestHeard))
        {
            if (!GetIsObjectValid(oClosestNonActive))
            {
                oClosestNonActive = oClosestHeard;
            }
        }
        // never consider dying henchman
        else if (!HenchGetAssociateState(NW_ASC_MODE_DYING, oClosestHeard)) 
        {
            break;
        }
        curCount++;
    }
    // find dying creatures to finish off
    if (iAmMonster && !GetIsObjectValid(oClosestNonActive))
    {
        curCount = 1;    
        while (1)
        {
            oClosestNonActive = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF,
                curCount, CREATURE_TYPE_IS_ALIVE, FALSE);
            if (!GetIsObjectValid(oClosestNonActive))
            {            
                break;                
            }
            if (GetPlotFlag(oClosestNonActive))
            {
                // ignore plot creatures  
            }
            else if (GetDistanceToObject(oClosestNonActive) >= 30.0)
            {
                oClosestNonActive = OBJECT_INVALID;
                break;
            }                
            if (GetCurrentHitPoints(oClosestNonActive) > HENCH_BLEAD_NEGHPS)
            {
                break;
            }
            curCount++;
        }
    }
    object oClosestSeenOrHeard;
    if (GetIsObjectValid(oClosestSummoned))
    {
        oClosestSeenOrHeard = oClosestSummoned;
    }
    else if (GetIsObjectValid(oClosestSeen))
    {
        oClosestSeenOrHeard = oClosestSeen;
    }
    else if (GetIsObjectValid(oClosestHeard))
    {
        oClosestSeenOrHeard = oClosestHeard;
    }
    else
    {
        oClosestSeenOrHeard = oClosestNonActive;  
    }

    object oFriend = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND,
                        OBJECT_SELF, 1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN,
                        CREATURE_TYPE_IS_ALIVE, TRUE);
                        
    float fDistance = GetDistanceToObject(oClosestSeenOrHeard);
    int iMeleeAttackers = fDistance <= 5.0;
    
    if (iEffectsOnSelf & HENCH_HAS_TIMESTOP_EFFECT)
    {
        // no one can attack while in time stop
        iMeleeAttackers = FALSE;
    }
    else if (oClosestSeenOrHeard == oClosestNonActive)
    {
        // no one can attack if non active
        iMeleeAttackers = FALSE;
    }
        // this is the first target, use
    object oLastTarget = GetLocalObject(OBJECT_SELF, "LastTarget");
    if (GetAbilityScore(OBJECT_SELF, ABILITY_INTELLIGENCE) < 7)
    {
        oLastTarget = OBJECT_INVALID;   
    }
    object oNotHeardOrSeen = OBJECT_INVALID;
    
    if(!GetIsObjectValid(oLastTarget) ||
        (GetIsDead(oLastTarget) && (GetCurrentHitPoints(oLastTarget) <= HENCH_BLEAD_NEGHPS)) ||
        !GetIsEnemy(oLastTarget) ||
        GetLocalInt(oLastTarget,"RunningAway") ||
        HenchGetAssociateState(NW_ASC_MODE_DYING, oLastTarget) ||
        GetPlotFlag(oLastTarget))
    {
        oLastTarget = OBJECT_INVALID;
    }
    else if (!GetObjectSeen(oLastTarget) && !GetObjectHeard(oLastTarget))
    {
        oLastTarget = OBJECT_INVALID;
    }
    else if (GetHasAnyEffect3(EFFECT_TYPE_PARALYZE, EFFECT_TYPE_FRIGHTENED, EFFECT_TYPE_SLEEP, oLastTarget) ||
        GetHasEffect(EFFECT_TYPE_PETRIFY, oLastTarget))
    {
        oLastTarget = OBJECT_INVALID;        
    }
    else if (GetArea(OBJECT_SELF) != GetArea(oLastTarget) || GetLocalInt(oLastTarget,"RunningAway"))
    {
        oLastTarget = OBJECT_INVALID;
    }
    if(!GetIsObjectValid(oIntruder) ||
        GetIsDead(oIntruder) ||
        GetLocalInt(oIntruder,"RunningAway") ||
        HenchGetAssociateState(NW_ASC_MODE_DYING, oIntruder) ||
        GetPlotFlag(oIntruder))
    {
        oIntruder = OBJECT_INVALID;
    }
    else if (!GetObjectSeen(oIntruder) && !GetObjectHeard(oIntruder))
    {
    // don't know where intruder is
        oNotHeardOrSeen = oIntruder;
        oIntruder = OBJECT_INVALID;
    }
    else if (GetArea(OBJECT_SELF) != GetArea(oIntruder))
    {
        oIntruder = OBJECT_INVALID;
    }
    if (!bForce)
    {
        oIntruder = OBJECT_INVALID;        
    }

    if (iHaveMaster)
    {
           // TODO more checks for allies
        if ((GetMaster(oIntruder) == oMaster) || (GetMaster(oIntruder) == oRealMaster))
        {
            oIntruder = OBJECT_INVALID;
        }
    }

    if (((d2() == 1) && (iEffectsOnSelf & HENCH_HAS_CONFUSED_EFFECT)) ||
        (iEffectsOnSelf & HENCH_HAS_CHARMED_EFFECT))
    {
        if (!GetIsObjectValid(oFriend))
        {
            // just do nothing for this case
            DeleteLocalObject(OBJECT_SELF, "LastTarget");
            return;
        }
        oIntruder = oFriend;
        oLastTarget = OBJECT_INVALID;
    }
    else if (iHaveMaster && oIntruder == oRealMaster)
    {
        if (GetHenchmanOptions(HENCH_HENAI_NOATTACK) & HENCH_HENAI_NOATTACK)
        {
            oIntruder = OBJECT_INVALID;
        }
    }
     
    // Get all enemies within 40 meters and store them in an array.
    // Auldar: Lets try 25 meters. 40 causes monsters to go too far past the PC
    // Tony K changed - this used to not use seen or heard, used all
    // enemies within a set radius (25)
    if(iAmMonster && !iMeleeAttackers &&
        (GetMonsterOptions(HENCH_MONAI_DISTRIB) & HENCH_MONAI_DISTRIB)
        && !GetIsObjectValid(oIntruder) && !GetIsObjectValid(oLastTarget) &&
        GetIsObjectValid(oClosestSeenOrHeard))
    {
        object oNextTarget;
        int perceptionType;
        if (GetIsObjectValid(oClosestSeen))
        {
            oNextTarget = oClosestSeen;
            perceptionType = PERCEPTION_SEEN;
        }
        else
        {
            oNextTarget = oClosestHeard;
            perceptionType = PERCEPTION_HEARD_AND_NOT_SEEN;
        }
        int iNth = 0;
        int iLoop = 1;
        while (GetIsObjectValid(oNextTarget) && GetDistanceToObject(oNextTarget) < 25.)
        {
            ++iLoop;
            if (!GetLocalInt(oNextTarget,"RunningAway") && !HenchGetAssociateState(NW_ASC_MODE_DYING, oNextTarget))
            {
                ++iNth;
                if (Random(iNth) == 0)
                {
                    oIntruder = oNextTarget;
                }
            }
            oNextTarget = GetNearestCreature(CREATURE_TYPE_REPUTATION,
                            REPUTATION_TYPE_ENEMY, OBJECT_SELF, iLoop,
                            CREATURE_TYPE_PERCEPTION, perceptionType,
                            CREATURE_TYPE_IS_ALIVE, TRUE);
        }
    }
   
        // Determine the best target
    if (!GetIsObjectValid(oIntruder))
    {
        if (GetIsObjectValid(oLastTarget) && GetDistanceToObject(oLastTarget) <= 5.0)
        {
            if (GetObjectSeen(oLastTarget))
            {
                oIntruder = oLastTarget;
            }
            else if (GetIsObjectValid(oClosestSeen) && GetDistanceToObject(oClosestSeen) <= 5.0)
            {
                oIntruder = oClosestSeen;
            }
            else if (GetIsObjectValid(oClosestSummoned) && GetDistanceToObject(oClosestSummoned) <= 5.0)
            {
                oIntruder = oClosestSummoned;
            }
            else
            {
                oIntruder = oLastTarget;
            }
        }
        else if (GetIsObjectValid(oClosestSeen) && GetDistanceToObject(oClosestSeen) <= 5.0)
        {
            oIntruder = oClosestSeen;
        }
        else if (GetIsObjectValid(oClosestSummoned) && GetDistanceToObject(oClosestSummoned) <= 5.0)
        {
            oIntruder = oClosestSummoned;
        }
        else if (GetIsObjectValid(oClosestHeard) && GetDistanceToObject(oClosestHeard) <= 5.0)
        {
            oIntruder = oClosestHeard;
        }
        else if (GetIsObjectValid(oLastTarget))
        {
            if (GetObjectSeen(oLastTarget))
            {
                oIntruder = oLastTarget;
            }
            else if (GetIsObjectValid(oClosestSeen))
            {
                oIntruder = oClosestSeen;
            }
            else if (GetIsObjectValid(oClosestSummoned))
            {
                oIntruder = oClosestSummoned;
            }
            else
            {
                oIntruder = oLastTarget;
            }
        }
        else if (GetIsObjectValid(oClosestSeen))
        {
            oIntruder = oClosestSeen;
        }
        else if (GetIsObjectValid(oClosestSummoned))
        {
            oIntruder = oClosestSummoned;
        }
        else if (GetIsObjectValid(oClosestHeard))
        {
            oIntruder = oClosestHeard;
        }
        else if (GetIsObjectValid(oClosestNonActive))
        {
            oIntruder = oClosestNonActive;            
        }
    }
    
    object oIntruderSeen;
    if (!GetObjectSeen(oIntruder))
    {
        if (!GetIsObjectValid(oClosestSeen) && GetObjectSeen(oClosestNonActive))
        {
            oIntruderSeen = oClosestNonActive;            
        }
        else
        {
            oIntruderSeen = oClosestSeen;
        }
    }
    else
    {
        oIntruderSeen = oIntruder;
    }
        
    // Auldar: If we are still in Search mode when we start to attack the enemy, stop searching.
    if (GetIsObjectValid(oIntruder) && GetActionMode(OBJECT_SELF, ACTION_MODE_DETECT))
    {
        SetActionMode(OBJECT_SELF, ACTION_MODE_DETECT, FALSE);
    }
    
    if (iAmMonster)
    {
        // reset scout mode (no wandering enable pursue to open doors)
        SetLocalInt(OBJECT_SELF,"ScoutMode", 0);
    }
    
    int iSummonHelp = TRUE;
    if (GetLocalInt(OBJECT_SELF, "DontSummon"))
        iSummonHelp = FALSE;
    int iUseMagic = GetLocalInt(OBJECT_SELF, "X2_L_STOPCASTING") != 10;              
      
    if (iHaveMaster && !GetIsObjectValid(oIntruder) && !GetIsObjectValid(oNotHeardOrSeen))
    {
        if (GetLocalInt(OBJECT_SELF, henchBuffCountStr))
        {        
            ExecuteScript("hench_o0_enhanc", OBJECT_SELF);
            return;                
        }
        if(HenchBashDoorCheck(oIntruder, iEffectsOnSelf & HENCH_HAS_POLYMORPH_EFFECT))
        {
            DeleteLocalInt(OBJECT_SELF, "AIIntruder");
            return;
        }
    }
    
    // The following tweaks are implemented via Pausanias's dialogue mods.
    int nClass = HenchDetermineClassToUse();
    // Herbivores should escape
   // special combat calls
    if(GetBehaviorState(NW_FLAG_BEHAVIOR_HERBIVORE) || nClass == CLASS_TYPE_COMMONER)
    {
        HenchTalentHide(iEffectsOnSelf, nGlobalMeleeAttackers);
        if (HenchTalentFlee(oIntruder)) return;
    }
    if (GetCombatCondition(X0_COMBAT_FLAG_COWARDLY) 
        && SpecialTacticsCowardly(oClosestSeenOrHeard))
    {
        return;
    }
        //This check is to see if the master is being attacked and in need of help
    if(GetAssociateState(NW_ASC_HAVE_MASTER))
    {
        if(GetAssociateState(NW_ASC_MODE_DEFEND_MASTER))
        {
            oIntruder = GetLastHostileActor(oRealMaster);
            if(!GetIsObjectValid(oIntruder))
            {
                oIntruder = GetGoingToBeAttackedBy(oRealMaster);
                if(!GetIsObjectValid(oIntruder))
                {
                    oIntruder = GetLastHostileActor();
                    if(!GetIsObjectValid(oIntruder))
                    {
                        if (GetAssociateState(NW_ASC_USE_RANGED_WEAPON))
                        {
                            if (fDistance > 20.)
                            {
                                DeleteLocalObject(OBJECT_SELF, "LastTarget");
                                return;
                            }
                        }
                        else if (fDistance > 7.0)
                        {
                            DeleteLocalObject(OBJECT_SELF, "LastTarget");
                            return;
                        }
                    }
                    else if(!GetIsEnemy(oIntruder))
                    {
                        oIntruder = OBJECT_INVALID;
                    }
                    else
                    {
                        bForce = TRUE;
                    }
                }
                else
                {
                    bForce = TRUE;
                }
            }
            else
            {
                bForce = TRUE;
            }
        }
    }

    // NEXT: Do not attack if the master told you not to
    if (GetLocalInt(OBJECT_SELF, "DoNotAttack") &&
        !(iEffectsOnSelf & (HENCH_HAS_CONFUSED_EFFECT | HENCH_HAS_CHARMED_EFFECT)))
    {
        if (d10() > 7 && (GetIsObjectValid(oIntruder) || GetIsObjectValid(oNotHeardOrSeen)))
        {
            if (iAmHenchman)
                SpeakString(sHenchHenchmanAskAttack);
            else if (iAmFamiliar)
                SpeakString(sHenchFamiliarAskAttack);
            else if (iAmCompanion)
                SpeakString("<" + GetName(OBJECT_SELF) + sHenchAnCompAskAttack);
            else
                SpeakString(sHenchOtherFollow1 + GetName(OBJECT_SELF) + sHenchOtherAskAttack);
        }
        // if in follow and can hear or see monsters and master not in stealth, turn off stealth
        // assumes master is running away and want to get close to master 
        // TODO removed - this could happen while master is moving towards enemy and wants henchman in stealth
//        if (GetIsObjectValid(oIntruder) && GetActionMode(OBJECT_SELF, ACTION_MODE_STEALTH) && !GetActionMode(oRealMaster, ACTION_MODE_STEALTH))
//        {
//            SetActionMode(OBJECT_SELF, ACTION_MODE_STEALTH, FALSE);
//        }
        ActionForceFollowObject(oRealMaster, HenchGetFollowDistance());
        return;
    }
    
    if (!GetIsObjectValid(oIntruder))
    {
        // henchmen using ranged weapons will not move to unheard and unseen enemies        
        if (!bForce && !iAmMonster && GetAssociateState(NW_ASC_USE_RANGED_WEAPON))
        {
            ActionMoveToObject(oRealMaster);
            ClearEnemyLocation();
        }
        else if (GetIsObjectValid(oNotHeardOrSeen))
        {
            SetEnemyLocation(oNotHeardOrSeen);
        }
        if (GetLocalInt(OBJECT_SELF, "LastSeenOrHeard"))
        {
            InitializeItemSpells(iEffectsOnSelf & HENCH_HAS_POLYMORPH_EFFECT, TRUE);

            // TODO have hench buff - need to check CR
            if (iUseMagic && iAmMonster && HenchTalentHide(iEffectsOnSelf, nGlobalMeleeAttackers))
            {
            }
            else if (iUseMagic  && iAmMonster && TK_UseBestSpell(OBJECT_INVALID, OBJECT_INVALID, oFriend, FALSE, FALSE,
                iSummonHelp, TRUE, TRUE, TRUE, FALSE, iAmMonster))
            {
            }
            else
            {            
                MoveToLastSeenOrHeard();
            }
        }
        else
        {
            CleanCombatVars();
            if (iAmMonster)
            {
                SetLocalObject(OBJECT_SELF, "NW_GENERIC_LAST_ATTACK_TARGET", OBJECT_INVALID);
                WalkWayPoints();
            }
            HenchEquipAppropriateWeapons(OBJECT_SELF, -5., FALSE, iEffectsOnSelf & HENCH_HAS_POLYMORPH_EFFECT);
        }
        DeleteLocalObject(OBJECT_SELF, "LastTarget");
        DeleteLocalInt(OBJECT_SELF, "AIIntruder");
        // nothing more to do
        return;
    }

    InitializeItemSpells(iEffectsOnSelf & HENCH_HAS_POLYMORPH_EFFECT, TRUE);
        
    ClearEnemyLocation();
    DeleteLocalInt(OBJECT_SELF, henchBuffCountStr);
    
    SetLocalObject(OBJECT_SELF, "LastTarget", oIntruder);    
    
    int combatRoundCount;
    combatRoundCount = GetLocalInt(OBJECT_SELF, henchCombatRoundStr);
    combatRoundCount ++;
    SetLocalInt(OBJECT_SELF, henchCombatRoundStr, combatRoundCount);
    
        //Shout that I was attacked
    if (!(iAmHenchman || iAmFamiliar || iAmCompanion) &&
        (HENCH_MONSTER_SHOUT_FREQUENCY > 0) &&
        (combatRoundCount % HENCH_MONSTER_SHOUT_FREQUENCY == 1))
    {
        SpeakString("NW_I_WAS_ATTACKED", TALKVOLUME_SILENT_TALK);
        SpeakString("NW_ATTACK_MY_TARGET", TALKVOLUME_SILENT_TALK);
    }
        
    // ----------------------------------------------------------------------------------------
    // July 27/2003 - Georg Zoeller,
    // Added to allow a replacement for determine combat round
    // If a creature has a local string variable named X2_SPECIAL_COMBAT_AI_SCRIPT
    // set, the script name specified in the variable gets run instead
    // see x2_ai_behold for details:
    // ----------------------------------------------------------------------------------------
    string sSpecialAI = GetLocalString(OBJECT_SELF,"X2_SPECIAL_COMBAT_AI_SCRIPT");
    if (sSpecialAI != "")
    {
        SetLocalObject(OBJECT_SELF,"X2_NW_I0_GENERIC_INTRUDER", oIntruder);
        ExecuteScript(sSpecialAI, OBJECT_SELF);
        if (GetLocalInt(OBJECT_SELF,"X2_SPECIAL_COMBAT_AI_SCRIPT_OK"))
        {
            DeleteLocalInt(OBJECT_SELF,"X2_SPECIAL_COMBAT_AI_SCRIPT_OK");
            return;
        }
    }    
    
        // try to go invis if have sneak attack at beginning of combat (helps with sneaking)
    if (iUseMagic && (combatRoundCount < 2 || GetHasFeat(FEAT_SNEAK_ATTACK)))
    {
        HenchTalentStealth(nGlobalMeleeAttackers);
    }    

    // Get distance closer than which henchman will swap to melee.
    float fThresholdDistance = GetLocalFloat(OBJECT_SELF,"HenchRange");
    if (fThresholdDistance == 0.0)
        fThresholdDistance = PAUSANIAS_DISTANCE_THRESHOLD;

    // Get challenge below which no defensive spells are cast
    float fThresholdChallenge = GetLocalFloat(OBJECT_SELF,"NewHenchChallenge");
    if (fThresholdChallenge == 0.0)
    {
        if (nClass == CLASS_TYPE_WIZARD || nClass == CLASS_TYPE_SORCERER)
        {
            fThresholdChallenge = -3.;
        }
        else
        {
            fThresholdChallenge = PAUSANIAS_CHALLENGE_THRESHOLD;
        }
    }

    // Signal to try to get some distance between self and the enemy.
    int iBackAway = FALSE;
    int nBackAway = GetLocalInt(OBJECT_SELF,"BackAway");
    if (fThresholdDistance > 50.0) {
        iBackAway = TRUE;
        fThresholdDistance = PAUSANIAS_DISTANCE_THRESHOLD;
    }

    // Monsters and non-associates do not care about the challenge rating for now.
    if (iAmMonster || !iHaveMaster)
        fThresholdChallenge = -100.;

    // Should I try to cast spells if monsters are nearby? Yes by default
    int iCastMelee = TRUE;
    if (GetLocalInt(OBJECT_SELF,"DoNotCastMelee"))
        iCastMelee = FALSE;

    int iHealMelee = TRUE;
    if (GetLocalInt(OBJECT_SELF,"DoNotHealMelee"))
        iHealMelee = FALSE;
        
    // The FIRST PRIORITY: self-preservation

    int nRacialType = GetRacialType(OBJECT_SELF);

    if (iCheckHealing && iAmMonster)
    {        
        int nMonsterDamageOpt = GetMonsterOptions(HENCH_MONAI_HASTE | HENCH_MONAI_HEALPT);
        if (nMonsterDamageOpt)
        {
            // Pausanias: Monsters get tougher for the harder game settings.
            if ((nMonsterDamageOpt & HENCH_MONAI_HASTE) &&
                !(iEffectsOnSelf & HENCH_HAS_HASTE_EFFECT))
            {
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectHaste(), OBJECT_SELF, 60.);
            }
            if ((nMonsterDamageOpt & HENCH_MONAI_HEALPT) && !(iHP < 20 &&
                GetDistanceToObject(oClosestSeenOrHeard) < 4.0))
            {
                if (GetCreatureUseItems(OBJECT_SELF) && nRacialType != RACIAL_TYPE_UNDEAD)
                {
                    int nHeal = GetLocalInt(OBJECT_SELF,"GaveHealing");
                    if (nHeal < (GetHitDice(OBJECT_SELF)/2))
                    {
                        ++nHeal;
                        SetLocalInt(OBJECT_SELF, "GaveHealing", nHeal);
                        CreateItemOnObject("NW_IT_MPOTION003", OBJECT_SELF, 1);
                    }
                }
            }
        }
    }
        
    float fChallenge;
    if (iAmMonster || !iHaveMaster)
    {
        // Monsters and non-associates do not care about the challenge rating for now.
        fChallenge = 100.0;
    }
    else
    {
        // Pausanias's Combined Challenge Rating (CCR)
        fChallenge = GetEnemyChallenge();
    }
    
      // I am a familiar or animal companion
    if ((iAmFamiliar || iAmCompanion) && GetIsObjectValid(oClosestSeenOrHeard))
    {
        // Get challenge above which familiar or animal companion will run away
        float fAssociateChallenge;
        int bFightToTheDeath;
        if (iAmFamiliar)
        {
            fAssociateChallenge = GetLocalFloat(oMaster, sHenchFamiliarChallenge);
            if (fAssociateChallenge == 0.0)
                fAssociateChallenge = PAUSANIAS_FAMILIAR_THRESHOLD;
            bFightToTheDeath = GetLocalInt(oMaster, sHenchFamiliarToDeath);
        }
        else
        {
            // default to 0.0 challenge if not set
            fAssociateChallenge = GetLocalFloat(oMaster, sHenchAniCompChallenge);
            bFightToTheDeath = GetLocalInt(oMaster, sHenchAniCompToDeath);
        }
        // Run away from tough enemies
        if (!bFightToTheDeath && (fChallenge >= fAssociateChallenge || (iHP < 40)))
        {
            if (iAmFamiliar)
            {
                switch (d10())
                {
                    case 1: SpeakString(sHenchFamiliarFlee1); return;
                    case 2: SpeakString(sHenchFamiliarFlee2); break;
                    case 3: SpeakString(sHenchFamiliarFlee3); break;
                    case 4: SpeakString(sHenchFamiliarFlee4); break;
                }
            }
            else
            {
                if (d3() == 1)
                {
                    SpeakString(sHenchAniCompFlee);
                }
            }
            ClearAllActions();
            HenchTalentHide(iEffectsOnSelf, nGlobalMeleeAttackers);
            ActionMoveAwayFromObject(oClosestSeenOrHeard,TRUE,40.);
            ActionMoveAwayFromObject(oClosestSeenOrHeard,TRUE,40.);
            ActionMoveAwayFromObject(oClosestSeenOrHeard,TRUE,40.);
            ActionMoveAwayFromObject(oClosestSeenOrHeard,TRUE,40.);
            SetLocalInt(OBJECT_SELF,"RunningAway",TRUE);
            return;
        }
    }    
    if (!iMeleeAttackers)
    {
        nGlobalMeleeAttackers = 0;
    }
        // Condition for immediate self-healing
    if (iCheckHealing)
    {        
        if (GetPercentageHPLoss(OBJECT_SELF) > 10)
        {        
                // if hidden, try to bring up to max HP
            if (HenchTalentHealingSelf(iEffectsOnSelf, InvisibleTrue())) return;
        }
        if ((iAmHenchman || iAmFamiliar) && GetLocalInt(OBJECT_SELF, "INeedHealing") == 2)
        {
            if (iAmHenchman)
            {
                if (Random(100) > 80) VoiceHealMe();
            }
            else
            {
                SpeakString(sHenchHealMe);
            }
        }
    }    

    // get in as many melee attacks as possible before spell ends
    if (GetHasSpellEffect(SPELL_TRUE_STRIKE))
    {
        if(HenchTalentMeleeAttack(oIntruder, fThresholdDistance, iMeleeAttackers,
            iAmMonster ? 0 : (iAmHenchman ? 1 : 2), iEffectsOnSelf & HENCH_HAS_POLYMORPH_EFFECT)) {return;}
        return;        
    }

    // NEXT priority: Heal master if needed.
    if (GetAssociateHealMaster())
    {
        if (fDistance > fThresholdDistance || iHealMelee)
        {
           if (HenchTalentHeal(iEffectsOnSelf, TRUE)) return;
           if (d10() > 6 &&
              (nClass == CLASS_TYPE_BARD || nClass == CLASS_TYPE_CLERIC ||
               nClass == CLASS_TYPE_DRUID || nClass == CLASS_TYPE_PALADIN))
                  SpeakString(sHenchCantHealMaster);
        }
        else
           if (d10() > 6)
               SpeakString(sHenchAskHealMaster);
    }
    
    // NEXT priority: follow or return to master for up to three rounds.
    int nFollow = GetLocalInt(OBJECT_SELF,"FollowCount");
    ++nFollow;
    if(iHaveMaster && !GetLocalInt(OBJECT_SELF,"RunningAway") &&
        (!iBackAway || GetLocalInt(OBJECT_SELF,"Scouting")))
    {
        SetLocalInt(OBJECT_SELF,"Scouting",FALSE);

        if(GetDistanceToObject(oRealMaster) > 15.0 && !GetObjectSeen(oRealMaster))
        {
            if(GetCurrentAction(oRealMaster) != ACTION_FOLLOW)
            {
                ActionForceFollowObject(oRealMaster, HenchGetFollowDistance());
                return;
            }
            else if (nFollow < 4)
            {
                return;
            }
        }
    }
    SetLocalInt(OBJECT_SELF,"FollowCount",0);
    
    // Pausanias: Combat has finally begun, so we are no longer scouting
    SetLocalInt(OBJECT_SELF,"Scouting", FALSE);
    SetLocalInt(OBJECT_SELF,"RunningAway", FALSE);

    int iPanicMode = (GetLocalInt(OBJECT_SELF, "INeedHealing") == 2 && iHP < 35) || (iHaveMaster && GetPercentageHPLoss(oRealMaster) < 35);
    if (iPanicMode)
    {
        //iCastMelee = TRUE;
        iHealMelee = TRUE;
        fChallenge = 90.0;
    }

// TODO HoTU adjust tactics to be more in line with HoTU overrides?
         // Should I try to cast spells if monsters are nearby? Yes by default
    int useAttackSpells = FALSE;
    int buffSelf = FALSE;
    int buffOthers = FALSE;
    int allowWeakOffSpells = FALSE;
    int allowAttackAbilities = FALSE;
    int allowBuffAbilities = FALSE;
    
    if (iUseMagic && fChallenge >= fThresholdChallenge)
    {
        buffSelf = TRUE;
        allowAttackAbilities = TRUE;
        allowBuffAbilities = TRUE;
        int nMaxHitDieTest = GetHitDice(OBJECT_SELF);
        if (nMaxHitDieTest > 9)
        {
            nMaxHitDieTest = 9;
        }
        if (!iMeleeAttackers)
        {
            switch (nClass)
            {
            case CLASS_TYPE_WIZARD:
            case CLASS_TYPE_SORCERER:
            case CLASS_TYPE_FEY:
            case CLASS_TYPE_OUTSIDER:
                useAttackSpells = TRUE;
                allowWeakOffSpells = d10(2) >= nMaxHitDieTest;
                buffOthers = d2() == 1;
                break;
            case CLASS_TYPE_BARD:
            case CLASS_TYPE_DRUID:
                useAttackSpells = TRUE;
                allowWeakOffSpells = useAttackSpells && d3(3) >= nMaxHitDieTest;
                buffOthers = d2() == 1;
                break;
            case CLASS_TYPE_CLERIC:
            case CLASS_TYPE_MAGICAL_BEAST:
                useAttackSpells = d3() != 1;
                allowWeakOffSpells = useAttackSpells && d3(3) >= nMaxHitDieTest;
                buffOthers = TRUE;
                break;
            default:
                useAttackSpells = d3() == 1;
                allowWeakOffSpells = useAttackSpells && d3(3) >= nMaxHitDieTest;
                buffOthers = TRUE;
                break;
            }
        }
        else if (iCastMelee)
        {
            switch (nClass)
            {
            case CLASS_TYPE_WIZARD:
            case CLASS_TYPE_SORCERER:
                useAttackSpells = TRUE;
                allowWeakOffSpells = d10(2) >= nMaxHitDieTest;
                buffOthers = d6() == 1;
                break;
            case CLASS_TYPE_BARD:
            case CLASS_TYPE_DRUID:
            case CLASS_TYPE_FEY:
            case CLASS_TYPE_OUTSIDER:
                useAttackSpells = d2() == 1;
                allowWeakOffSpells = useAttackSpells && d4() >= nMaxHitDieTest;
                buffOthers = d6() == 1;
                break;
            case CLASS_TYPE_CLERIC:
            case CLASS_TYPE_MAGICAL_BEAST:
                useAttackSpells = d4() == 1;
                allowWeakOffSpells = useAttackSpells && d4() >= nMaxHitDieTest;
                buffOthers = d4() == 1;
                break;
            default:
                useAttackSpells = d8() == 1;
                allowWeakOffSpells = useAttackSpells && d4() >= nMaxHitDieTest;
                buffOthers = d10() == 1;
                break;
            }
        }
    }    
        
        // if raging, then turn off most spell casting
    if (GetHasSpellEffect(SPELLABILITY_RAGE_5) || GetHasSpellEffect(SPELLABILITY_RAGE_4) ||
        GetHasSpellEffect(SPELLABILITY_RAGE_3) || GetHasSpellEffect(SPELLABILITY_FEROCITY_2) ||
        GetHasSpellEffect(SPELLABILITY_FEROCITY_1) || GetHasSpellEffect(SPELL_BLOOD_FRENZY) ||
        GetHasFeatEffect(FEAT_BARBARIAN_RAGE) || GetHasFeatEffect(SPELLABILITY_FEROCITY_3))
    {
        useAttackSpells = FALSE;
        buffSelf = buffSelf && d6() == 1;
        buffOthers = FALSE;
        allowWeakOffSpells = FALSE;
        iSummonHelp = FALSE;
    }
        // if have melee attack bonuses, then turn off most spell casting
    else if (GetHasSpellEffect(SPELLABILITY_DIVINE_STRENGTH) || GetHasSpellEffect(SPELLABILITY_DIVINE_PROTECTION) ||
        GetHasSpellEffect(SPELL_DIVINE_POWER) || GetHasSpellEffect(SPELLABILITY_BATTLE_MASTERY) ||
        GetHasSpellEffect(SPELL_DIVINE_FAVOR) || GetHasFeatEffect(FEAT_DIVINE_MIGHT) ||
        GetHasFeatEffect(FEAT_DIVINE_SHIELD))        
    {
        useAttackSpells = FALSE;
        buffSelf = buffSelf && d2() == 1;
        buffOthers = FALSE;
        allowWeakOffSpells = FALSE;
        iSummonHelp = FALSE;
    }
    // TODO change this to still use potions and items (move to GetHasFixed spell)
    if ((nClass == CLASS_TYPE_SORCERER || nClass == CLASS_TYPE_WIZARD) && GetArcaneSpellFailure(OBJECT_SELF) > 20)
    {
        useAttackSpells = FALSE;
        buffSelf = FALSE;
        buffOthers = FALSE;
        allowWeakOffSpells = FALSE;
        iSummonHelp = FALSE;
    }    

    if (!GetIsObjectValid(oIntruderSeen))
    {
        useAttackSpells = FALSE;
        allowAttackAbilities = FALSE;
        allowWeakOffSpells = FALSE;
    }

        // I am a henchman
    if (GetIsObjectValid(oClosestSeenOrHeard) && ((iAmHenchman && iBackAway) || GetCombatCondition(X0_COMBAT_FLAG_RANGED)))
    {
        if (fDistance < 8.0 && fDistance > 3.0)
        {
        // Try to get some distance for up to 3 rounds if told to do so.
            if (iBackAway && nBackAway < 4)
            {
                ActionMoveAwayFromObject(oClosestSeenOrHeard, TRUE, 15.0);
                ++nBackAway;
                SetLocalInt(OBJECT_SELF,"BackAway",nBackAway);
                return;
            }
        }
        SetLocalInt(OBJECT_SELF,"BackAway",0);
    }
    int iCloseBuff = 0;
    if (iAmHenchman && GetIsObjectValid(oClosestSeenOrHeard))
    {
        // 5% chance per round of speaking the relative challenge of the encounter.
        if (d20() == 1)
        {
            if (fChallenge < -3.) SpeakString(sHenchWeakAttacker);
            else if (fChallenge < -1.) SpeakString(sHenchModAttacker);
            else if (fChallenge < 2.) SpeakString(sHenchStrongAttacker);
            else SpeakString(sHenchOverpoweringAttacker);
        }

        // Logic: if we are at close range, and the encounter is tough
        // Then Buff the PC up once, and then fight. Otherwise, if
        // we are at close range, fight; else 20% chance of using
        // the missile weapon. Sorcerors or wizards try to cast spells
        // rather than fight.

        if ((nClass != CLASS_TYPE_WIZARD && nClass != CLASS_TYPE_SORCERER) ||
            !iCastMelee)
        {
            if (iCastMelee && iMeleeAttackers && !iPanicMode)
            {
                if (fChallenge >= 0.0)
                {
                    iCloseBuff = GetLocalInt(OBJECT_SELF,"CloseRangeEnhanced");
                    iCloseBuff++;
                    if (iCloseBuff == 1)
                    {
                        buffOthers = TRUE; buffSelf = FALSE;
                    }
                    else if (iCloseBuff == 2)
                    {
                        buffOthers = FALSE; buffSelf = TRUE;
                    }
                    else
                    {
                        buffOthers = FALSE; buffSelf = FALSE;
                    }
                }
                else
                {
                    buffOthers = FALSE; buffSelf = FALSE;
                }
            }
            // 30% chance of attacking weak opponents outright even if
            // they are not at close range.
            // There's a 20% chance of attacking anyway if the missile weapon is equipped.
            if (iMeleeAttackers || (fChallenge < -3. && d100() < 30) ||
                (GetAssociateState(NW_ASC_USE_RANGED_WEAPON) && (d100() < 20)))
            {
                useAttackSpells = FALSE;
                buffSelf = FALSE;
                buffOthers = FALSE;
                allowWeakOffSpells = FALSE;
                iSummonHelp = FALSE;
            }
        }
    }        
        // check for area effect spells damaging self
    if (CheckAOEForSelf()) {return;}        

    /* TODO leave out for now     
    if (GetCombatCondition(X0_COMBAT_FLAG_AMBUSHER) 
        && SpecialTacticsAmbusher(oClosestSeenOrHeard))
    {
        return;
    }*/

        //Remove negative effects from allies
    if(iUseMagic && HenchTalentCureCondition()) {return;}
        //Check if allies or self are injured
    if(iUseMagic && HenchTalentHeal(iEffectsOnSelf, FALSE)) {return;}

    if (allowBuffAbilities)
    {
         if (HenchTalentPersistentAbilities()) {return;}
         if(HenchTalentBardSong()) {return;}
    }
    
    if (InvisibleTrue())
    {
        // while invisible do maximum amount of buffing & summoning
        int result = TK_UseBestSpell(OBJECT_INVALID, OBJECT_INVALID, oFriend, FALSE, FALSE,
            iSummonHelp, buffSelf, buffOthers, allowBuffAbilities, FALSE, iAmMonster);
        if ((iCloseBuff == 1 && result == TK_BUFFOTHER) || (iCloseBuff == 2 && result == TK_BUFFSELF))
        {
            SetLocalInt(OBJECT_SELF,"CloseRangeEnhanced", iCloseBuff);
        }
        if (result) { return; }        
        iSummonHelp = FALSE;
        buffSelf = FALSE;
        allowBuffAbilities = FALSE;        
    }
        
        // transformation spells if got here for druid or shifter
    if (iUseMagic && allowAttackAbilities && GetLevelByClass(CLASS_TYPE_DRUID))
    {
        if (HenchTalentAdvancedPolymorph(iEffectsOnSelf & HENCH_HAS_POLYMORPH_EFFECT)) { return; }
    }
    
    int result = TK_UseBestSpell(oIntruderSeen, oClosestHeard, oFriend, useAttackSpells, allowAttackAbilities,
        iSummonHelp, buffSelf, buffOthers, allowBuffAbilities, allowWeakOffSpells, iAmMonster);
    if ((iCloseBuff == 1 && result == TK_BUFFOTHER) || (iCloseBuff == 2 && result == TK_BUFFSELF))
    {
        SetLocalInt(OBJECT_SELF,"CloseRangeEnhanced", iCloseBuff);
    }
    if (result) { return; }

        // transformation spells if got here for wizard, sor, or druid
    if (iUseMagic && buffSelf && !(iEffectsOnSelf & HENCH_HAS_POLYMORPH_EFFECT))
    {
        if (HenchTalentPolymorph()) { return; }
    }
        
    if (!iMeleeAttackers && GetIsObjectValid(oIntruderSeen) && (!iAmHenchman || GetAssociateState(NW_ASC_USE_RANGED_WEAPON)) && GetCreatureUseItems(OBJECT_SELF))
    {
        if (HenchUseGrenade(oIntruderSeen)) { return; }
    }    
        //Attack if out of spells
    if(HenchTalentMeleeAttack(oIntruder, fThresholdDistance, iMeleeAttackers,
        iAmMonster ? 0 : (iAmHenchman ? 1 : 2), iEffectsOnSelf & HENCH_HAS_POLYMORPH_EFFECT)) {return;}
}
