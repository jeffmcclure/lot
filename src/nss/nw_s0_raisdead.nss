//::///////////////////////////////////////////////
//:: [Raise Dead]
//:: [NW_S0_RaisDead.nss]
//:: Copyright (c) 2000 Bioware Corp.
//:://////////////////////////////////////////////
//:: Brings a character back to life with 1 HP.
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 31, 2001
//:: Modified 69MEH69 July2003
//:://////////////////////////////////////////////
//:: Last Updated By: Preston Watamaniuk, On: April 11, 2001
//:: VFX Pass By: Preston W, On: June 22, 2001
#include "69_i0_henchman"
void main()
{
    //Declare major variables
    object oTarget = GetSpellTargetObject();
    effect eRaise = EffectResurrection();
    effect eVis = EffectVisualEffect(VFX_IMP_RAISE_DEAD);

    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_RAISE_DEAD, FALSE));
    if(GetIsDead(oTarget) &&  GetIsHenchmanDying(oTarget) == FALSE)
    {
        //Apply raise dead effect and VFX impact
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetLocation(oTarget));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eRaise, oTarget);
        if(GetDidDie(oTarget)) //Added for henchman
        {
         PostRespawnCleanup(oTarget);
        }
    }
}

