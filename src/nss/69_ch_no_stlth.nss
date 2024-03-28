//::///////////////////////////////////////////////
//:: Check if Stealth Disabled
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Does the henchman currently not use stealth when
    moving.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On:
//:: Modified 69MEH69 OCT 2002
//:://////////////////////////////////////////////
#include "NW_I0_GENERIC"

int StartingConditional()
{
   if(!GetAssociateState(NW_ASC_AGGRESSIVE_STEALTH))
    {
        return TRUE;
    }
    return FALSE;
}
