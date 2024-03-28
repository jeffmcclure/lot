//::///////////////////////////////////////////////
//:: Cure Light Wounds
//:: NW_S0_CurLgtW
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
// When laying your hand upon a living creature,
// you channel positive energy that cures 1d8 points
// of damage plus 1 point per caster level (up to +5).
// Since undead are powered by negative energy, this
// spell inflicts damage on them instead of curing
// their wounds. An undead creature can attempt a
// Will save to take half damage.
*/
//:://////////////////////////////////////////////
//:: Created By: Brennon Holmes
//:: Created On: Oct 12, 2000
//:: Modified: 69MEH69 JUL2003 Henchman bleeding
//:://////////////////////////////////////////////
//:: Update Pass By: Preston W, On: July 26, 2001
#include "69_i0_henchman"
#include "NW_I0_SPELLS"
void main()
{
    object oTarget = GetSpellTargetObject();
    string sTag = GetTag(oTarget);
    object oArea = GetArea(oTarget);
    int nCHP = GetLocalInt(oArea, "nCHP" +sTag);
    int nCure = d8(1);
    spellsCure(nCure, 5, 8, VFX_IMP_SUNSTRIKE, VFX_IMP_HEALING_S, GetSpellId());
    if(GetIsHenchmanDying(oTarget) && GetRacialType(oTarget) != RACIAL_TYPE_UNDEAD)
    {
        SetLocalInt(oArea, "nCHP" +sTag, nCHP + nCure);
    }
}

