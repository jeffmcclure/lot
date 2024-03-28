//::///////////////////////////////////////////////
//:: Disable Traps Yes Help
//:://////////////////////////////////////////////
/*
    Does the henchman currently not help with traps
*/
//:://////////////////////////////////////////////
//:: Created By: 69MEH69 DEC2002
//:: Created On:
//:://////////////////////////////////////////////
#include "69_inc_henai"
int StartingConditional()
{
    if(GetAssociateState(NW_ASC_DISARM_TRAPS, OBJECT_SELF) == TRUE)
    {
        return TRUE;
    }
    return FALSE;
}
