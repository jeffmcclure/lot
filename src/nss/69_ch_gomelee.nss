//::///////////////////////////////////////////////
//:: Set To Melee Only
//:: nw_ch_gomelee
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Makes the henchmen go to melee combat.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: April 5th, 2002
//:://////////////////////////////////////////////

#include "69_inc_henai"
void main()
{
    //SetAssociateState(NW_ASC_USE_RANGED_WEAPON, FALSE);
    ClearAllActions();
    //EquipAppropriateWeapons(GetRealMaster());
    mhEquipMelee(GetNearestEnemy(), OBJECT_SELF);
}
