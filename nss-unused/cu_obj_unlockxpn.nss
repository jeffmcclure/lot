
// Ben W-Husey (B G P Hughes)
// This script rewards the PC for unlocking a door/placeable based on the difficulty of the lock - not to be used on doors with keys.
// Include cu_functions for AllParty to work  (prevents multiple characters getting the same xp in the same party)
#include "CU_FUNCTIONS"
//#include "nw_i0_tool"

void main()
{
    string sLockName = "un"+GetTag(OBJECT_SELF);      //Set variable sLockName to object's tag
    int nOnce = GetLocalInt(GetLastUnlocked(), sLockName);  //Check to see if PC has unlocked this door before
    int nLockXPGain = GetLockUnlockDC(OBJECT_SELF) +30;  //Give xp equal to unlock DC + 20 (set as you like)
    object oPC = GetLastUnlocked();  // oPC is the unlocking PC
    if (nLockXPGain < 0)             // Make sure minimum xp given is 10
        {nLockXPGain = 10;}
    if (nOnce==FALSE)                //If not given XP before for unlocking this Lock, then run the routine now
    {
    GiveXPToCreature (GetLastUnlocked(), nLockXPGain); // Give XP (nLockXPGain) to unlocking PC.
    FloatingTextStringOnCreature("XP Gained - use of skill",GetLastUnlocked()); //Inform PC of XP for use of skill
    AllParty(sLockName,oPC,1);  //Set so no one else in the party (and the opener) can get this xp again.
    }
}
