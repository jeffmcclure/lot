//:://////////////////////////////////////////////////
//:: X0_D1_HEN_HIRED
//:: Copyright (c) 2002 Floodgate Entertainment
//:://////////////////////////////////////////////////
/*
Handles the hiring of a henchman.
 */
//:://////////////////////////////////////////////////
//:: Created By: Naomi Novik
//:: Created On: 09/13/2002
//:://////////////////////////////////////////////////
#include "x0_i0_henchman"


void main()
{
    object oPC = GetPCSpeaker();


    object oTarget1 = GetHenchman(oPC,1);

    if (oTarget1 == OBJECT_INVALID)

    {
    //Ensure plot/immortal flags has been turned off
    SetPlotFlag(OBJECT_SELF, FALSE);
    SetImmortal(OBJECT_SELF, FALSE);

    AddHenchman(GetPCSpeaker());
     // Set the variables
    SetLocalInt(GetPCSpeaker(), "kirath released off radial menu?", 1);
    }

    object oTarget2 = GetHenchman(oPC,2);

    if (oTarget2 == OBJECT_INVALID)

    {
    //Ensure plot/immortal flags has been turned off
    SetPlotFlag(OBJECT_SELF, FALSE);
    SetImmortal(OBJECT_SELF, FALSE);

    AddHenchman(GetPCSpeaker());
     // Set the variables
    SetLocalInt(GetPCSpeaker(), "kirath released off radial menu?", 1);
    }
}





