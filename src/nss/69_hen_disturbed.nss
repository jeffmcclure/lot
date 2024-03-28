//::///////////////////////////////////////////////
//:: Henchmen: On Disturbed
//:: 69_hen_disturbed
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Determine Combat Round on disturbed.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 16, 2001
//::///////////////////////////////////////////

// * Make me hostile the faction of my last attacker (TEMP)
//  AdjustReputation(OBJECT_SELF,GetFaction(GetLastAttacker()),-100);
// * Determined Combat Round
#include "69_inc_henai"

void main()
{
    object oTarget = GetLastDisturbed();

    if(GetSpawnInCondition(NW_FLAG_DISTURBED_EVENT))
    {
        SignalEvent(OBJECT_SELF, EventUserDefined(1008));
    }
}
