//::///////////////////////////////////////////////
//:: Check if Search Disabled
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
#include "NW_I0_GENERIC"

int StartingConditional()
{
    if(!GetAssociateState(NW_ASC_AGGRESSIVE_SEARCH) && GetDetectMode(OBJECT_SELF) != 1)
    {
        return TRUE;
    }
    return FALSE;
}
