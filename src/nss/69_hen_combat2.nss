//::///////////////////////////////////////////////
//:: Associate: End of Combat Round End
//:: 69_hen_combatend
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Calls the end of combat script every round
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 16, 2001
//:://////////////////////////////////////////////
#include "69_inc_henai"
void main()
{
    if(GetIsInCombat(OBJECT_SELF) == FALSE)
    {
     object oEnemy = GetNearestSeenEnemy(OBJECT_SELF);
     if(GetAssociateState(NW_ASC_USE_RANGED_WEAPON))
     {
      ClearAllActions();
      ActionEquipMostDamagingRanged(oEnemy);
     }
     else if(!GetAssociateState(NW_ASC_USE_RANGED_WEAPON))
     {
      ClearAllActions();
      ActionEquipMostDamagingMelee(oEnemy, TRUE);
     }
    }
    if(!GetSpawnInCondition(NW_FLAG_SET_WARNINGS))
    {
       HenchmenCombatRound(GetNearestSeenEnemy());
    }
    if(GetSpawnInCondition(NW_FLAG_END_COMBAT_ROUND_EVENT))
    {
        SignalEvent(OBJECT_SELF, EventUserDefined(1003));
    }
}

