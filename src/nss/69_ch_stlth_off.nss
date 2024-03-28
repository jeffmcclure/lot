//::///////////////////////////////////////////////
//:: Turn Off Stealth Mode
//:: NW_CH_SRCH_ON.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Nov 19, 2001
//:: Modified 69MEH69 OCT2002
//:://////////////////////////////////////////////
#include "NW_I0_GENERIC"

void main()
{
    SetAssociateState(NW_ASC_AGGRESSIVE_STEALTH, FALSE);
    ActionUseSkill(SKILL_HIDE, OBJECT_SELF); //69MEH69: Turn off Stealth
}
