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

//#include "x0_i0_henchman"

void main()
{

    if (AbleToTalk(OBJECT_SELF) && (GetCurrentAction() != ACTION_OPENLOCK))  //|| GetCurrentAction() != ACTION_OPENLOCK)

    {

        int nMatch = GetListenPatternNumber();
        object oShouter = GetLastSpeaker();
        object oIntruder;
        object oMaster = GetMaster();
        object oFleeFrom = GetNearestEnemy();
        object oNearestSeenEnemy = GetNearestSeenEnemy();
        object oItem_in_left_hand;
        object oItem_being_used_in_left_hand;

        if (nMatch == -1)
            {
            ClearAllActions();
            BeginConversation();
            }
        else if (GetCommandable(OBJECT_SELF) == TRUE && GetIsObjectValid(oShouter) && GetMaster() == oShouter)

        {

        switch (nMatch)

                {


              //  case 1://T'kron Scout Ahead
              //  {
              //      object oClosest =  GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY,
              //                          OBJECT_SELF, 1);
              //      if (GetIsObjectValid(oClosest)) {
              //          SetLocalInt(OBJECT_SELF,"Scouting",TRUE);
              //          SetLocalObject(OBJECT_SELF,"ScoutTarget",oClosest);
              //          ClearAllActions();
              //          ActionForceFollowObject(oClosest,1.0);
              //          ActionForceFollowObject(oClosest,1.0);
              //          ActionForceFollowObject(oClosest,1.0);
              //      } else
              //          SetLocalInt(OBJECT_SELF,"Scouting",FALSE);
              //  }

              //  case ASSOCIATE_COMMAND_DISARMTRAP:
              //  case 2://disarm trap
              //      {
              //      bkAttemptToDisarmTrap(GetNearestTrapToObject(GetMaster()), TRUE);
              //      break;
              //      }
              //
              //
              //  case ASSOCIATE_COMMAND_PICKLOCK:
              //  case 3://open lock
              //      {
              //      object Lock = GetLockedObject(oMaster);
              //      if (GetLocalInt(GetArea(OBJECT_SELF),"Count3")==3 && GetTag(Lock)=="Sundial")
              //          {
              //          SetLocalObject(GetArea(OBJECT_SELF),"Lock",Lock);
              //          PlayVoiceChat(VOICE_CHAT_CANDO);
              //          //PiroStandGround(TRUE);
              //         ClearAllActions(TRUE);
              //          ActionMoveToObject(Lock,TRUE,0.5);
              //          ActionStartConversation(GetFirstPC(),"mv_lastlock",FALSE,FALSE);
              //          //ActionDoCommand(PiroStandGround(FALSE));
              //          }
              //      else if (GetTag(Lock)=="CenterChamberDoor" && GetIsObjectValid(GetItemPossessedBy(OBJECT_SELF,"APKey")))
              //          {
              //          ActionUseSkill(SKILL_OPEN_LOCK,Lock);
              //         }
              //      else
              //          bkManualPickNearestLock();
              //      break;
              //      }

                case 4://T'kron hide
                    {
                    ClearAllActions();
                    ActionUseSkill(SKILL_HIDE,OBJECT_SELF);
                    break;
                    }

                case 5://hide
                    {
                    ClearAllActions();
                    ActionUseSkill(SKILL_HIDE,OBJECT_SELF);
                    break;
                    }

                case 6://arm melee weapon
                    {
                    ClearAllActions();

                    oItem_being_used_in_left_hand = GetLocalObject(OBJECT_SELF, "Item being used in left hand");

                    if(GetIsObjectValid(oItem_being_used_in_left_hand))
                    {
                    AssignCommand(OBJECT_SELF, ActionEquipItem(oItem_being_used_in_left_hand,INVENTORY_SLOT_LEFTHAND));
                    }

                    DelayCommand(0.1, ActionEquipMostDamagingMelee());
                    //Use melee weapons by default
                    SetAssociateState(NW_ASC_USE_RANGED_WEAPON, FALSE);
                    break;
                    }

                case 7://arm ranged weapon
                    {
                    ClearAllActions();

                    oItem_in_left_hand = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, OBJECT_SELF);
                    if(GetIsObjectValid(oItem_in_left_hand))
                    {
                        oItem_being_used_in_left_hand = oItem_in_left_hand;
                        SetLocalObject(OBJECT_SELF, "Item being used in left hand", oItem_being_used_in_left_hand);
                    }

                    ActionEquipMostDamagingRanged();
                    //Use ranged weapons by default
                    SetAssociateState(NW_ASC_USE_RANGED_WEAPON, TRUE);
                    break;
                    }

                case 12://T'kron come here
                    {
                    SpeakString("I will be right there.");
                    SetAssociateState(NW_ASC_MODE_STAND_GROUND,TRUE);
                    ClearAllActions();
                    ActionMoveToLocation(GetLocation(oMaster),TRUE);
                    ActionDoCommand(SetAssociateState(NW_ASC_MODE_STAND_GROUND,FALSE));
                    break;
                    }

                case 13://come here
                    {
                    SpeakString("I will be right there.");
                    SetAssociateState(NW_ASC_MODE_STAND_GROUND,TRUE);
                    ClearAllActions();
                    ActionMoveToLocation(GetLocation(oMaster),TRUE);
                    ActionDoCommand(SetAssociateState(NW_ASC_MODE_STAND_GROUND,FALSE));
                    break;
                    }
            ///    case 14://talk to me
            //        {
            //        int State = GetAssociateState(NW_ASC_MODE_STAND_GROUND);
            //        ClearAllActions(TRUE);
            //        SetCommandable(TRUE,oShouter);
            //        ActionResumeConversation();
            //        AssignCommand(oShouter,ClearAllActions(TRUE));
            //        SetAssociateState(NW_ASC_MODE_STAND_GROUND,TRUE);
            //        ActionStartConversation(oShouter);
            //        ActionDoCommand(SetAssociateState(NW_ASC_MODE_STAND_GROUND,State));
            //        break;
            //        }

                case 14://T'kron attack
                    {

                    if (oNearestSeenEnemy == OBJECT_INVALID)
                        {
                        SpeakString("What manner of evil would you like me to vanquish?");
                        }
                    else
                        {
                        if (GetIsFighting(OBJECT_SELF))
                            {
                            SpeakString("I am already cleansing this place of these vile spawn!");
                            }
                        else
                            {
                            SetAssociateState(NW_ASC_MODE_STAND_GROUND,TRUE);
                            ClearAllActions();
                            PlayVoiceChat(VOICE_CHAT_ATTACK);
                            ActionAttack(oFleeFrom, FALSE);
                            }
                        }
                    break;
                    //       ExecuteScript("henchman_ai",OBJECT_SELF);
                    }



                case ASSOCIATE_COMMAND_ATTACKNEAREST:
                case 15://attack
                    {

                    if (oNearestSeenEnemy == OBJECT_INVALID)
                        {
                        SpeakString("What manner of evil would you like me to vanquish?");
                        }
                    else
                        {
                        if (GetIsFighting(OBJECT_SELF))
                            {
                            SpeakString("I am already cleansing this place of these vile spawn!");
                            }
                        else
                            {
                            SetAssociateState(NW_ASC_MODE_STAND_GROUND,TRUE);
                            ClearAllActions();
                            PlayVoiceChat(VOICE_CHAT_ATTACK);
                            ActionAttack(oFleeFrom, FALSE);
                            }
                        }
                    break;
                    //       ExecuteScript("henchman_ai",OBJECT_SELF);
                    }


                //case 16://cast ...
                //    {
                //    string Shout = GetMatchedSubstring(1);
                //    if (GetIsInCombat())
                //        FloatingTextStringOnCreature("**"+HenchName()+" cannot cast in combat**",oMaster);
                //    else
                //        {
                //        if(Shout == "Light on me" || Shout == "light on me")
                //            {
                //            if (HasSpell("Light"))
                //                CastSpell(SPELL_LIGHT,GetFirstPC());
                //            }
                //       else if(Shout == "Light on yourself" || Shout == "light on yourself")
                //            {
                //            if (HasSpell("Light"))
                //                CastSpell(SPELL_LIGHT,OBJECT_SELF);
                //            }
                //        else if(Shout == "Cat's Grace" || Shout == "cat's grace")
                //            {
                //            if (HasSpell("Cat's Grace"))
                //                CastSpell(SPELL_CATS_GRACE,OBJECT_SELF);
                //            }
                //        else if(Shout == "Recall" || Shout == "recall")
                //            {
                //            string Area = GetLocalString(oMaster,"area");
                //            if (HasSpell("Recall"))
                //               switch(GetLocalInt(GetFirstPC(),"RecallReady"))
                //                    {
                //                    case 0:
                //                        SpeakString("I don't think that this is an appropriate time to use a Recall scroll");
                //                        SetLocalInt(GetFirstPC(),"Recall",GetLocalInt(GetFirstPC(),"Recall")+1);
                //                        break;
                //                    case 1:
                //                        if(InDemonPits() && GetJournalEntry("Daggers")==20)
                //                            {
                //                            int Journal = GetJournalEntry("Mokura");
                //                            string Token = "we decided to go after after the Drow Daggers, but had to leave before getting them.  It was too dangerous and time was short.";
                //                            AddJournalQuestEntry("Daggers",40,GetFirstPC());
                //                            if (Journal == 20)
                //                               SetCustomToken(500,Token);
                //                            else
                //                                SetCustomToken(501,Token);
                //                            AddJournalQuestEntry("Mokura",Journal+10,GetFirstPC());
                //                            }
                //                        SetLocalInt(GetFirstPC(),"RecallReady",0);
                //                        SetLocalInt(GetFirstPC(),"timer",0);
                //                        CastSpell(SPELL_POLYMORPH_SELF,OBJECT_SELF);
                //                        break;
                //                    case 2:
                //                        SpeakString("And go back to Mokura?  You're crazy.");
                //                        SetLocalInt(GetFirstPC(),"Recall",GetLocalInt(GetFirstPC(),"Recall")+1);
                //                        break;
                //                    }
                //            }
                //        else if(Shout == "Shadow Armor" || Shout == "shadow armor")
                //            {
                //            if (HasSpell("Shadow Armor"))
                //                CastSpell(SPELL_SHADOW_SHIELD,OBJECT_SELF);
                //            }
                //        else
                //            SpeakString("Cast what?");
                        //PiroStandGround(FALSE);
                //        }
                //    break;
                //    }

                case 16://T'kron wait there
                    {
                    SpeakString("Very well, I will wait here patiently for your return.");
                    ClearAllActions();
                    SetAssociateState(NW_ASC_MODE_STAND_GROUND,TRUE);
                    //ClearAllActions();
                    //ActionSpeakString("Make it quick.  I won't wait long.");
                    //ActionWait(15.0);
                    //ActionDoCommand(PiroStandGround(FALSE));
                    break;
                    }

                case ASSOCIATE_COMMAND_STANDGROUND:
                case 17://wait there
                    {
                    SpeakString("Very well, I will wait here patiently for your return.");
                    ClearAllActions();
                    SetAssociateState(NW_ASC_MODE_STAND_GROUND,TRUE);
                    //ClearAllActions();
                    //ActionSpeakString("Make it quick.  I won't wait long.");
                    //ActionWait(15.0);
                    //ActionDoCommand(PiroStandGround(FALSE));
                    break;
                    }

                    case 20: //T'kron Fall Back
                    {

                        if (oNearestSeenEnemy == OBJECT_INVALID)
                            {
                            SpeakString("I trust your judgement and will fall back.");
                            }
                            else if (GetDistanceToObject(GetNearestEnemy())<5.0 && GetIsObjectValid(GetNearestEnemy()))
                                {
                                SetAssociateState(NW_ASC_MODE_STAND_GROUND,TRUE);
                                ClearAllActions();
                                PlayVoiceChat(VOICE_CHAT_FLEE);
                                //ActionMoveAwayFromLocation(GetLocation(OBJECT_SELF), TRUE, 5.5);

                                ActionMoveAwayFromObject(oFleeFrom,TRUE,5.5);
                                }
                                else
                                {
                                SpeakString("I do not think there is anything to fear at this moment.");
                                }

                    break;
                    }

                    case 21: //Fall Back
                    {

                        if (oNearestSeenEnemy == OBJECT_INVALID)
                            {
                            SpeakString("I trust your judgement and will fall back.");
                            }
                            else if (GetDistanceToObject(GetNearestEnemy())<5.0 && GetIsObjectValid(GetNearestEnemy()))
                                {
                                SetAssociateState(NW_ASC_MODE_STAND_GROUND,TRUE);
                                ClearAllActions();
                                PlayVoiceChat(VOICE_CHAT_FLEE);
                                //ActionMoveAwayFromLocation(GetLocation(OBJECT_SELF), TRUE, 5.5);

                                ActionMoveAwayFromObject(oFleeFrom,TRUE,5.5);
                                }
                                else
                                {
                                SpeakString("I do not think there is anything to fear at this moment.");
                                }

                    break;
                    }
            }
        }

    if (GetIsHenchmanDying() == TRUE)
    {
        return;
    }
    //object oShouter = GetLastSpeaker();
    //object oMaster = GetMaster();
    //int nMatch = GetListenPatternNumber();

    //object oIntruder;

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
}
