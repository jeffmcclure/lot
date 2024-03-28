//::///////////////////////////////////////////////
//:: Cure Minor Wounds
//:: NW_S0_CurMinW
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
// As cure light wounds, except cure minor wounds
// cures only 1 point of damage
*/
//:://////////////////////////////////////////////
//:: Created By: Noel Borstad
//:: Created On: Oct 18, 2000
//:: Modified: 69MEH69 JUL2003
//:://////////////////////////////////////////////
//:: Last Updated By: Preston Watamaniuk, On: Feb 22, 2001
//:: Last Updated By: Preston Watamaniuk, On: April 6, 2001
#include "69_i0_henchman"
#include "NW_I0_SPELLS"
void main()
{
    object oTarget = GetSpellTargetObject();
    string sTag = GetTag(oTarget);
    object oArea = GetArea(oTarget);
    int nCHP = GetLocalInt(oArea, "nCHP" +sTag);
    int nCure = 1;
    spellsCure(4, 0, 4, VFX_IMP_SUNSTRIKE, VFX_IMP_HEAD_HEAL, GetSpellId());
    if(GetIsHenchmanDying(oTarget) && GetRacialType(oTarget) != RACIAL_TYPE_UNDEAD)
    {
        SetLocalInt(oArea, "nCHP" +sTag, nCHP + nCure);
    }
}
