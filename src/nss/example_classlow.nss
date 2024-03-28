//::///////////////////////////////////////////////
//:: General Treasure Spawn Script
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Spawns in general purpose treasure, usable
    by all classes.
*/
//:://////////////////////////////////////////////
//:: Created By:   Brent
//:: Created On:   February 26 2001
//:://////////////////////////////////////////////
#include "NW_O2_CONINCLUDE"
#include "rl_inc_spchest"
void main()

{
    ChestRespawner();
    if (GetLocalInt(OBJECT_SELF,"NW_DO_ONCE") != 0)
    {
           DestroyPotions();
       return;
    }

    object oLastOpener = GetLastOpener();
    GenerateLowTreasure(oLastOpener, OBJECT_SELF);
    SetLocalInt(OBJECT_SELF,"NW_DO_ONCE",1);
    ShoutDisturbed();
    DestroyPotions();
}
