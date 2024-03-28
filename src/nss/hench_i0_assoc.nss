/*

    Henchman Inventory And Battle AI

    This file contains some modifications of the default
    associate functions. 

*/

#include "hench_i0_act"

// Modified form of ResetHenchmenState
// sets the henchmen to commandable, deletes locals
// having to do with doors and clears actions    
// Modified by Tony K to clear more things
void HenchResetHenchmenState();

// Modified form of GetFollowDistance used for scouting
// Written by Pausanias
float HenchGetFollowDistance();

// Modified form of GetAssociateState
int HenchGetAssociateState(int nCondition, object oAssoc=OBJECT_SELF);


void HenchResetHenchmenState()
{
    SetCommandable(TRUE);
    DeleteLocalObject(OBJECT_SELF, "NW_GENERIC_DOOR_TO_BASH");
    DeleteLocalInt(OBJECT_SELF, "NW_GENERIC_DOOR_TO_BASH_HP");
    DeleteLocalInt(OBJECT_SELF, henchBuffCountStr);
    SetAssociateState(NW_ASC_IS_BUSY, FALSE);
    ClearForceOptions();
    ClearAllActions();
}


float HenchGetFollowDistance()
{
    float fDistance;

    if (GetLocalInt(OBJECT_SELF,"Scouting")) return 100.;

    if(GetAssociateState(NW_ASC_DISTANCE_2_METERS))
    {
        fDistance = 2.0;
    }
    else if(GetAssociateState(NW_ASC_DISTANCE_4_METERS))
    {
        fDistance = 4.0;
    }
    else if(GetAssociateState(NW_ASC_DISTANCE_6_METERS))
    {
        fDistance = 6.0;
    }
    return fDistance;
}


int HenchGetAssociateState(int nCondition, object oAssoc=OBJECT_SELF)
{
    if(nCondition == NW_ASC_HAVE_MASTER)
    {
        if(GetIsObjectValid(GetMaster(oAssoc)))
            return TRUE;
    }
    else
    {
        int nPlot = GetLocalInt(oAssoc, "NW_ASSOCIATE_MASTER");
        if(nPlot & nCondition)
            return TRUE;
    }
    return FALSE;
}
