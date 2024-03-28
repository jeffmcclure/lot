//::///////////////////////////////////////////////
//:: Check if Stealth Enabled
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Does the henchman currently use stealth when
    moving.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On:
//:://////////////////////////////////////////////
//:: Brent: May 2002: Disabled this option
//:: 69MEH69 OCT2002 Enabled this option

#include "69_inc_henai"

int StartingConditional()
{
    if(GetAssociateState(NW_ASC_AGGRESSIVE_STEALTH))
    {
        return TRUE;
    }
    return FALSE;
}
