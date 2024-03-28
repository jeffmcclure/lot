//::///////////////////////////////////////////////
//:: Heal
//:: [NW_S0_Heal.nss]
//:: Copyright (c) 2000 Bioware Corp.
//:://////////////////////////////////////////////
//:: Heals the target to full unless they are undead.
//:: If undead they reduced to 1d4 HP.
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 12, 2001
//:: Modified 69MEH69 JUL2003
//:://////////////////////////////////////////////
//:: Update Pass By: Preston W, On: Aug 1, 2001
#include "69_i0_henchman"
#include "NW_I0_SPELLS"
void main()
{
  //Declare major variables
  object oTarget = GetSpellTargetObject();
  effect eKill, eHeal;
  int nDamage, nHeal, nModify, nMetaMagic, nTouch;
  effect eSun = EffectVisualEffect(VFX_IMP_SUNSTRIKE);
  effect eHealVis = EffectVisualEffect(VFX_IMP_HEALING_X);
  string sTag = GetTag(oTarget);
  object oArea = GetArea(oTarget);
    //Check to see if the target is an undead
    if (GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD)
    {
        if(!GetIsReactionTypeFriendly(oTarget))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_HEAL));
            //Make a touch attack
            if (TouchAttackMelee(oTarget))
            {
                //Make SR check
                if (!MyResistSpell(OBJECT_SELF, oTarget))
                {
                    //Roll damage
                    nModify = d4();
                    nMetaMagic = GetMetaMagicFeat();
                    //Make metamagic check
                    if (nMetaMagic == METAMAGIC_MAXIMIZE)
                    {
                        nModify = 1;
                    }
                    //Figure out the amount of damage to inflict
                    nDamage =  GetCurrentHitPoints(oTarget) - nModify;
                    //Set damage
                    eKill = EffectDamage(nDamage, DAMAGE_TYPE_POSITIVE);
                    //Apply damage effect and VFX impact
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eKill, oTarget);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eSun, oTarget);
                }
            }
        }
    }
    else
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_HEAL, FALSE));
        //Figure out how much to heal
        nHeal = GetMaxHitPoints(oTarget);
        //Set the heal effect
        eHeal = EffectHeal(nHeal);
        //Apply the heal effect and the VFX impact
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHealVis, oTarget);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);
        if(GetIsHenchmanDying(oTarget))
        {
        SetLocalInt(oArea, "nCHP" +sTag, 21);
        }
    }
}
