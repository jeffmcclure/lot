// Ben W-Husey (B G P Hughes)
// This script rewards the PC for disarming the trap based on trap difficulty - the whole party is also rewarded a lesser amount for trap removal
// Include cu_functions for PartyGotEntry to work
#include "cu_functions"
#include "nw_i0_tool"

void main()
{
    string sTrapName = GetTag(OBJECT_SELF);      //Set variable sTrapName to object's tag
    int nOnce = GetLocalInt(GetLastDisarmed(), sTrapName);  //Check to see if PC has disarmed this trap before
    int nTrapXPGain = GetTrapDisarmDC(OBJECT_SELF) -10;  //Give xp equal to disarm DC - 10 (set as you like)
    object oPC = GetLastDisarmed();  // oPC is the disarming PC
    if (nTrapXPGain < 0)             // Make sure minimum xp given is 10
        {nTrapXPGain = 10;}
    if (nOnce==FALSE)                //If not given XP before for disarming this trap, then run the routine now
    {
    GiveXPToCreature (GetLastDisarmed(), nTrapXPGain*2); // Give XP (nTrapXPGain) to disarming PC (in this case doubled as hard trap).
    FloatingTextStringOnCreature("XP Gained - use of skill",GetLastDisarmed()); //Inform PC of XP for use of skill
    PartyGotEntry(sTrapName,oPC,nTrapXPGain/2, "XP gain - trap disarmed");  //Reward whole party TrapXPGain/2 for trap removal, tell all party members what XP is for, and set the variable so the XP cannot be gained again for this trap.
    }
}
