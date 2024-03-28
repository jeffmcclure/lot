//::///////////////////////////////////////////////
//:: Check if Search Enabled
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Does the henchman currently not search when
    moving.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On:
//:://////////////////////////////////////////////
//:: Brent: May 2002: Disabled this option
//:: 69MEH69 enabled this option
#include "69_inc_henai"

int StartingConditional()
{
    if(GetAssociateState(NW_ASC_AGGRESSIVE_SEARCH))
    {
        return TRUE;
    }
    return FALSE;
}
