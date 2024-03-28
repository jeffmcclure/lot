//::///////////////////////////////////////////////
//:: Associate: Heartbeat
//:: 69_hen_heartbeat
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Move towards master or wait for him
    Modified by Pausanias to improve the Battle AI and include
    nifty's bard song fix.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Nov 21, 2001
//:://////////////////////////////////////////////
#include "69_inc_henai"
#include "xp_i0_levelup"
void main()
{
  if (GetLocalInt(OBJECT_SELF, "nXPLevelUp") == 1)
  {
    object oMaster = GetRealMaster(OBJECT_SELF);
    int nMXP = GetXP(oMaster);
    int nXP = GetLocalInt(OBJECT_SELF, "nMasterXP");
    int nHXP = GetLocalInt(OBJECT_SELF, "nHenchXP");
    int nLvl = GetHitDice(OBJECT_SELF);
    if (nMXP > nXP)
    {
      int nAddXP = nMXP - nXP;
      int nNewHXP = nAddXP + nHXP;
      SetLocalInt(OBJECT_SELF, "nHenchXP", nNewHXP);
      SetLocalInt(OBJECT_SELF, "nMasterXP", nMXP);
      XPLevelUpHenchman(OBJECT_SELF);
    }
  }
    if(IsInConversation(OBJECT_SELF) || GetIsInCombat(OBJECT_SELF))
        return;
    if(GetLocalInt(OBJECT_SELF, "NW_FORMERHENCH_CHECK") == TRUE)
    {
     if(GetStealthMode(OBJECT_SELF) == STEALTH_MODE_ACTIVATED)
     {
      SetAssociateState(NW_ASC_AGGRESSIVE_STEALTH, FALSE);
      ActionUseSkill(SKILL_HIDE, OBJECT_SELF);
     }
     if(GetDetectMode(OBJECT_SELF) == DETECT_MODE_ACTIVE)
     {
      SetAssociateState(NW_ASC_AGGRESSIVE_SEARCH, FALSE);
      ActionUseSkill(SKILL_SEARCH, OBJECT_SELF);
     }
     SetLocalInt(OBJECT_SELF, "NW_FORMERHENCH_CHECK", FALSE);
    }

    if(!GetAssociateState(NW_ASC_IS_BUSY))
    {
        //BardRest();

        object oMaster = GetRealMaster();
        //Seek out and disable undisabled traps
        object oTrap = GetNearestTrapToObject();
        object oMasterTrap = GetNearestTrapToObject(oMaster, FALSE);
        float fTrap = GetDistanceToObject(oTrap);
        float fMasterTrap = GetDistanceToObject(oMasterTrap);
        if((GetTrapDetectedBy(oMasterTrap, oMaster) == TRUE) && (fMasterTrap <= 5.0))
        {
        SetTrapDetectedBy(oMasterTrap, OBJECT_SELF);
        bkAttemptToDisarmTrap(oMasterTrap, FALSE);
        }
        else if((GetTrapDetectedBy(oTrap, OBJECT_SELF) == TRUE) && (fTrap <= 10.0))
        {
         SetTrapDetectedBy(oTrap, oMaster);
         bkAttemptToDisarmTrap(oTrap, FALSE);
        }

        if (GetCurrentAction(OBJECT_SELF) == ACTION_FOLLOW)
            MyPrintString("****ON HB: FOLLOW****");
        if (GetCurrentAction(OBJECT_SELF) == ACTION_DISABLETRAP)
            MyPrintString("****ON HB: TRAP****");
        if (GetCurrentAction(OBJECT_SELF) == ACTION_OPENLOCK)
            MyPrintString("****ON HB: LOCK****");
        if (GetCurrentAction(OBJECT_SELF) == ACTION_REST)
            MyPrintString("****ON HB: REST****");
        if (GetCurrentAction(OBJECT_SELF) == ACTION_ATTACKOBJECT)
            MyPrintString("****ON HB: ATTACK****");

        if(GetIsObjectValid(oMaster) &&
            GetCurrentAction(OBJECT_SELF) != ACTION_DISABLETRAP &&
            GetCurrentAction(OBJECT_SELF) != ACTION_OPENLOCK &&
            GetCurrentAction(OBJECT_SELF) != ACTION_REST &&
            GetCurrentAction(OBJECT_SELF) != ACTION_ATTACKOBJECT)
        {

            // Pausanias: Hench tends to get stuck on follow.
            if (GetCurrentAction(OBJECT_SELF) == ACTION_FOLLOW) {
                if (GetDistanceToObject(GetRealMaster()) >= 2.2 &&
                    GetAssociateState(NW_ASC_DISTANCE_2_METERS)) return;
                if (GetDistanceToObject(GetRealMaster()) >= 4.2 &&
                    GetAssociateState(NW_ASC_DISTANCE_4_METERS)) return;
                if (GetDistanceToObject(GetRealMaster()) >= 6.2 &&
                    GetAssociateState(NW_ASC_DISTANCE_6_METERS)) return;
                ClearAllActions();
            }

            //object oClosest = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN);
            object oClosest = GetNearestSeenEnemy(OBJECT_SELF, 1);

            MyPrintString("********* ON HEARTBEAT: ASC IS NOT BUSY *************");
            if(
               !GetIsObjectValid(GetAttackTarget()) &&
               !GetIsObjectValid(GetAttemptedSpellTarget()) &&
               !GetIsObjectValid(GetAttemptedAttackTarget()) &&
               !GetIsObjectValid(oClosest)
              )
            {

                /*if (GetLocalInt(OBJECT_SELF,"SwitchedToMelee") &&
                    GetAssociateState(NW_ASC_USE_RANGED_WEAPON)) {
                    ClearAllActions();
                    SetLocalInt(OBJECT_SELF,"SwitchedToMelee",FALSE);
                    EquipAppropriateWeapons(OBJECT_SELF);
                    return;
                }*/
                 MyPrintString("********* ON HEARTBEAT: ASC IS NOT ATTACKING *************");
                if(GetDistanceToObject(GetRealMaster()) > GetLocalFloat(OBJECT_SELF, "HenchDistance"))
                {
                    if(GetAssociateState(NW_ASC_HAVE_MASTER))
                    {
                        if(!GetIsFighting(OBJECT_SELF))
                        {
                            if(!GetAssociateState(NW_ASC_MODE_STAND_GROUND))
                            {
                                if(GetDistanceToObject(GetRealMaster()) > GetFollowDistance())
                                {
                                    ClearAllActions();
                                    if(GetAssociateState(NW_ASC_AGGRESSIVE_STEALTH) || GetAssociateState(NW_ASC_AGGRESSIVE_SEARCH))
                                    {
                                         if(GetAssociateState(NW_ASC_AGGRESSIVE_STEALTH) && (GetStealthMode(OBJECT_SELF) == STEALTH_MODE_DISABLED))
                                         {
                                            ActionUseSkill(SKILL_HIDE, OBJECT_SELF);
                                         }
                                         if(GetAssociateState(NW_ASC_AGGRESSIVE_SEARCH) && GetDetectMode(OBJECT_SELF) != 1)
                                         {
                                            ActionUseSkill(SKILL_SEARCH, OBJECT_SELF);
                                         }
                                         MyPrintString("GENERIC SCRIPT DEBUG STRING ********** " + "Assigning Force Follow Command with Search and/or Stealth");
                                         ActionForceFollowObject(oMaster, GetFollowDistance());
                                    }
                                    else
                                    {
                                         MyPrintString("GENERIC SCRIPT DEBUG STRING ********** " + "Assigning Force Follow Normal");
                                         ActionForceFollowObject(oMaster, GetFollowDistance());
                                         //ActionForceMoveToObject(GetRealMaster(), TRUE, GetFollowDistance(), 5.0);
                                    }
                                }
                            }
                        }
                    }
                }
                else if(!GetAssociateState(NW_ASC_MODE_STAND_GROUND))
                {
                    if(GetIsObjectValid(oMaster) && !GetLocalInt(OBJECT_SELF,"Scouting"))
                    {
                        if(GetCurrentAction(oMaster) != ACTION_REST)
                        {
                            ClearAllActions();
                            if(GetAssociateState(NW_ASC_AGGRESSIVE_STEALTH) || GetAssociateState(NW_ASC_AGGRESSIVE_SEARCH))
                            {
                                 if(GetAssociateState(NW_ASC_AGGRESSIVE_STEALTH) && GetStealthMode(OBJECT_SELF) == STEALTH_MODE_DISABLED)
                                 {
                                    ActionUseSkill(SKILL_HIDE, OBJECT_SELF);
                                 }
                                 if(GetAssociateState(NW_ASC_AGGRESSIVE_SEARCH) && GetDetectMode(OBJECT_SELF) != 1)
                                 {
                                    ActionUseSkill(SKILL_SEARCH, OBJECT_SELF);
                                 }
                                 MyPrintString("GENERIC SCRIPT DEBUG STRING ********** " + "Assigning Force Follow Command with Search and/or Stealth");
                                 ActionForceFollowObject(oMaster, GetFollowDistance());
                            }
                            else
                            {
                                 MyPrintString("GENERIC SCRIPT DEBUG STRING ********** " + "Assigning Force Follow Normal");
                                 ActionForceFollowObject(oMaster, GetFollowDistance());
                            }
                        }
                    }
                }
            }
            else if(GetIsObjectValid(oClosest) && GetObjectSeen(oClosest) &&
                    GetCurrentAction() != ACTION_ATTACKOBJECT &&
                    GetCurrentAction() != ACTION_CASTSPELL &&
                    GetCurrentAction() != ACTION_HEAL &&
                   !GetAssociateState(NW_ASC_MODE_STAND_GROUND))
            {
                MyPrintString("********* ON HEARTBEAT: ASC IDLE, SO ENTER COMBAT *************");
                DetermineCombatRound();
            }
            else
              MyPrintString("********* ON HEARTBEAT: ALREADY IN COMBAT *************");

            if (GetLocalInt(OBJECT_SELF,"Scouting")) {
                if (GetDistanceToObject(GetRealMaster()) < 6.0)
                    //SpeakString("Please get out of my way.");
                ActionForceFollowObject(GetLocalObject(OBJECT_SELF,"ScoutTarget"),1.0);
            }
        }
        if(GetSpawnInCondition(NW_FLAG_HEARTBEAT_EVENT))
        {
            SignalEvent(OBJECT_SELF, EventUserDefined(1001));
        }
    } else
      MyPrintString("********* ON HEARTBEAT: ASC IS BUSY *************");
}


