//::///////////////////////////////////////////////
//:: Associate: On Percieve
//:: 69_hen_perceived
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Nov 19, 2001
//:://////////////////////////////////////////////

#include "69_inc_henai"

void main()
{
    object oPC = GetRealMaster(OBJECT_SELF);
    //This is the equivalent of a force conversation bubble, should only be used if you want an NPC
    //to say something while he is already engaged in combat.
    if(GetSpawnInCondition(NW_FLAG_SPECIAL_COMBAT_CONVERSATION))
    {
        ActionStartConversation(OBJECT_SELF);
    }
    if(!GetAssociateState(NW_ASC_MODE_STAND_GROUND) && GetLocalInt(OBJECT_SELF, MH_MODE_ATTACK) == TRUE)
    {
        //Do not bother checking the last target seen if already fighting
            // PAUS: No, actually please do check
        if(!GetIsObjectValid(GetAttemptedAttackTarget()) &&
           !GetIsObjectValid(GetAttackTarget()) &&
           !GetIsObjectValid(GetAttemptedSpellTarget()))
        {
            //Check if the last percieved creature was actually seen
            if(GetLastPerceptionSeen())
            {
                object oSeen = GetLastPerceived();
                if(oSeen == oPC)
                {
                  oSeen = GetNearestSeenEnemy(OBJECT_SELF, 1);
                }
                float fSeen = GetDistanceBetween(oSeen, OBJECT_SELF);
                float fEnemy = GetLocalFloat(OBJECT_SELF, "EnemyPerceived");
                float fDiff = fSeen - fEnemy;


                //69MEH69 Fixed so that the henchman does not shout at dead bodies
                if(GetIsEnemy(oSeen) && GetIsDead(GetLastPerceived()) == FALSE && GetObjectSeen(oSeen, OBJECT_SELF) == TRUE)
                {
                  //Testing
                  //string sName = GetName(OBJECT_SELF);
                  //string sSeen = FloatToString(fSeen);
                  //string sDiff = FloatToString(fDiff);
                  //SendMessageToPC(oPC, "The enemy is " +sSeen+ " meters from " +sName);
                  //SendMessageToPC(oPC, "The difference is " +sDiff);
                  //End Testing
                    if(GetDetectMode(OBJECT_SELF) == 1)
                    {
                     SetAssociateState(NW_ASC_AGGRESSIVE_STEALTH, FALSE);
                     ActionUseSkill(SKILL_SEARCH, OBJECT_SELF);
                    }
                    //SetFacingPoint(GetPosition(GetLastPerceived()));
                    BattleCry();
                    if(!GetIsInCombat(OBJECT_SELF))// && (fDiff <= 0.0))
                    {
                     //SendMessageToPC(oPC, "Attacking perceived enemy");
                     HenchmenCombatRound(oSeen);
                    }
                }
                //Linked up to the special conversation check to initiate a special one-off conversation
                //to get the PCs attention
                else if(GetSpawnInCondition(NW_FLAG_SPECIAL_CONVERSATION) && GetIsPC(GetLastPerceived()))
                {
                    ActionStartConversation(OBJECT_SELF);
                }
            }
        }
    }
    if(GetSpawnInCondition(NW_FLAG_PERCIEVE_EVENT))
    {
        SignalEvent(OBJECT_SELF, EventUserDefined(1002));
    }
}

/*
#include "NW_I0_GENERIC"

void main()
{
    // * If have no master then run default scripts
    if (GetIsObjectValid(GetMaster()) == FALSE)
    {
        ExecuteScript("nw_c2_default2",OBJECT_SELF);
    }
    else
    {
        object oNoticed = GetLastPerceived();
        object oTarget = GetAttackTarget();
        if(GetIsObjectValid(oNoticed) && !GetIsObjectValid(GetAttemptedAttackTarget()))
        {
            if (GetLastPerceptionSeen() && GetIsEnemy(oNoticed))
            {
                DetermineCombatRound();
            }
            else if(GetLastPerceptionVanished() && oTarget == oNoticed)
            {
                 ClearAllActions();
            }
        }
    }
}
//Could just use the same one as the generic
*/
