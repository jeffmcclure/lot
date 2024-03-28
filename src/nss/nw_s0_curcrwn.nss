//::///////////////////////////////////////////////
//:: Cure Critical Wounds
//:: NW_S0_CurCrWn
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
// As cure light wounds, except cure critical wounds
// cures 4d8 points of damage plus 1 point per
// caster level (up to +20).
*/
//:://////////////////////////////////////////////
//:: Created By: Noel Borstad
//:: Created On: Oct 18, 2000
//:: Modified: 69MEH69 JUL2003
//:://////////////////////////////////////////////
//:: VFX Pass By: Preston W, On: June 20, 2001
//:: Update Pass By: Preston W, On: July 26, 2001
#include "69_i0_henchman"
#include "NW_I0_SPELLS"
void main()
{
    object oTarget = GetSpellTargetObject();
    string sTag = GetTag(oTarget);
    object oArea = GetArea(oTarget);
    int nCHP = GetLocalInt(oArea, "nCHP" +sTag);
    int nCure = d8(4);
    spellsCure(nCure, 20, 32, VFX_IMP_SUNSTRIKE, VFX_IMP_HEALING_G, GetSpellId());
    if(GetIsHenchmanDying(oTarget) && GetRacialType(oTarget) != RACIAL_TYPE_UNDEAD)
    {
        SetLocalInt(oArea, "nCHP" +sTag, nCHP + nCure);
    }
}

