/************************ [User Defined: Pickpocket for XP] ********************
    Filename: j_ude_pickpkxp
************************* [User Defined: Pickpocket for XP] ********************
    User defined event: When pickpocketed, award XP.
************************* [History] ********************************************
    1.3 - Example of User Defined Event
************************* [Workings] *******************************************
    This just awards a small XP bonus to anyone who pickpockets the NPC.

    Note:
    - As disturbed only fires if the NPC spots it, it is kinda dodgy.
    - Could use a message to say why they got X experience.
************************* [User Defined: Pickpocket for XP] *******************/

// XP to give to pickpocketer
const int XP_GIVE = 50;

//  This contains a lot of useful things.
//  - Combat starting
//  - Constant values
//  - Get/Set spawn in values.
#include "j_inc_other_ai"
//  This contains some useful things to get NPC's to attack and so on.
#include "j_inc_npc_attack"

void main()
{
    // Get the user defined number.
    int iEvent = GetUserDefinedEventNumber();
    // Events.
    switch(iEvent)
    {
        // Event Disturbed
        case AI_FLAG_UDE_DISTURBED_PRE_EVENT:
        {
            // Get last disturber (must be a pickpocket)
            object oDisturber = GetLastDisturbed();
            if(GetIsObjectValid(oDisturber) && GetIsPC(oDisturber))
            {
                // Award the XP.
                GiveXPToCreature(oDisturber, XP_GIVE);
            }
        }
        break;
    }
}
