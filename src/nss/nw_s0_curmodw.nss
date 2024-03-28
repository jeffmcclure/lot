//::///////////////////////////////////////////////
//:: Cure Moderate Wounds
//:: NW_S0_CurModW
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
// As cure light wounds, except cure moderate wounds
// cures 2d8 points of damage plus 1 point per
// caster level (up to +10).
*/
//:://////////////////////////////////////////////
//:: Created By: Noel Borstad
//:: Created On: Oct 18, 2001
//:: Modified: 69MEH69 JUL2003
//:://////////////////////////////////////////////
//:: Update Pass By: Preston W, On: July 25, 2001
#include "69_i0_henchman"
#include "NW_I0_SPELLS"
void main()
{
    object oTarget = GetSpellTargetObject();
    string sTag = GetTag(oTarget);
    object oArea = GetArea(oTarget);
    int nCHP = GetLocalInt(oArea, "nCHP" +sTag);
    int nCure = d8(2);
    spellsCure(nCure, 10, 16, VFX_IMP_SUNSTRIKE, VFX_IMP_HEALING_M, GetSpellId());
    if(GetIsHenchmanDying(oTarget) && GetRacialType(oTarget) != RACIAL_TYPE_UNDEAD)
    {
        SetLocalInt(oArea, "nCHP" +sTag, nCHP + nCure);
    }
}

