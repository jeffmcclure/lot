//::///////////////////////////////////////////////
//:: Turn Off Search Mode
//:: NW_CH_SRCH_ON.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Nov 19, 2001
//:: Modified Oct 2002 69MEH69
//:://////////////////////////////////////////////
#include "NW_I0_GENERIC"

void main()
{
    SetAssociateState(NW_ASC_AGGRESSIVE_SEARCH, FALSE);
    ActionUseSkill(SKILL_SEARCH, OBJECT_SELF);
}
