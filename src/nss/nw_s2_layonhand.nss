//::///////////////////////////////////////////////
//:: Lay_On_Hands
//:: NW_S2_LayOnHand.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The Paladin is able to heal his Chr Bonus times
    his level.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Aug 15, 2001
//:: Modified 69MEH69 JUL2003
//:://////////////////////////////////////////////
#include "69_i0_henchman"
#include "NW_I0_SPELLS"
void main()
{
    //Declare major variables
    object oTarget = GetSpellTargetObject();
    int nChr = GetAbilityModifier(ABILITY_CHARISMA);
    if (nChr < 0)
    {
        nChr = 0;
    }
    int nLevel = GetLevelByClass(CLASS_TYPE_PALADIN);
    //Caluclate the amount to heal
    int nHeal = nLevel * nChr;
    if(nHeal <= 0)
    {
        nHeal = 1;
    }
    effect eHeal = EffectHeal(nHeal);
    effect eVis = EffectVisualEffect(VFX_IMP_HEALING_M);
    effect eVis2 = EffectVisualEffect(VFX_IMP_SUNSTRIKE);
    effect eDam;
    int nTouch;
    string sTag = GetTag(oTarget);
    object oArea = GetArea(oTarget);
    int nCHP = GetLocalInt(oArea, "nCHP" +sTag);
    //Check if the target is an undead
    if(GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD)
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_LAY_ON_HANDS));
        //Make a ranged touch attack
        nTouch = TouchAttackMelee(oTarget);
        if(nTouch > 0)
        {
            if(nTouch == 2)
            {
                nHeal *= 2;
            }
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_LAY_ON_HANDS));
            eDam = EffectDamage(nHeal, DAMAGE_TYPE_DIVINE);
            //Apply the VFX impact and effects
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget);
        }
    }
    else
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_LAY_ON_HANDS, FALSE));
        //Apply the VFX impact and effects
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
        if(GetIsHenchmanDying(oTarget))
        {
          SetLocalInt(oArea, "nCHP" +sTag, nCHP + nHeal);
        }
    }

}

