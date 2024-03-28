//:://////////////////////////////////////////////////
//:: X0_CH_HEN_DAMAGE
/*
  OnDamaged event handler for henchmen/associates.
 */
//:://////////////////////////////////////////////////
//:: Copyright (c) 2002 Floodgate Entertainment
//:: Created By: Naomi Novik
//:: Created On: 01/06/2003
//:://////////////////////////////////////////////////



void main()
{
    ExecuteScript("nw_ch_ac6", OBJECT_SELF);

    //object ocontroldeathblock = GetObjectByTag("controldeathblock");

    //if (GetLocalInt(ocontroldeathblock, "SetIsDestroyable is set for Kirath, TRUE, TRUE, TRUE") == 0)
    //{
    //SetIsDestroyable(TRUE, TRUE, TRUE);
    //DelayCommand(0.1, SetLootable(OBJECT_SELF, TRUE));
    //SetLocalInt(ocontroldeathblock, "SetIsDestroyable is set for Kirath, TRUE, TRUE, TRUE", 1);
    //}
}
