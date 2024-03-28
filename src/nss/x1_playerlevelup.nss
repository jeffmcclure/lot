//::///////////////////////////////////////////////
//:: x1_playerlevelup
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Levels up the player's henchman
*/
//:://////////////////////////////////////////////
//:: Created By:
//:: Created On:
//:://////////////////////////////////////////////
#include "x0_i0_henchman"
#include "hench_i0_henutil"

void main()
{
   // SpawnScriptDebugger();
    object oPC =  GetPCLevellingUp();
    CopyFamiliarAnimalCompanionItems(oPC);
    LevelUpXP1Henchman(oPC);
}
