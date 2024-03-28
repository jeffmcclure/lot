/************************ [User Defined: Specific Damage: Die] *****************
    Filename: j_ude_damdie
************************* [User Defined: Specific Damage: Die] *****************
    User defined event: Damaged: Die.
************************* [History] ********************************************
    1.3 - Example of User Defined Event
************************* [Workings] *******************************************
    Once this NPC is damaged by a specific damage type, which here is defined
    as Sonic - so perhaps something that would shatter, dies.
************************* [User Defined: Specific Damage: Die] ****************/

// Damage which will kill us - must be a DAMAGE_TYPE_*
const int DAMAGE_WE_DONT_LIKE = DAMAGE_TYPE_SONIC;

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
        // Event Damaged
        case EVENT_DAMAGED_PRE_EVENT:
        {
            // If damage done was sonic, we die, plain and simple.
            if(GetDamageDealtByType(DAMAGE_WE_DONT_LIKE) > 0)
            {
                // Kill ourselves
                effect eDeath = EffectDeath(TRUE);
                object oDamager = GetLastDamager();
                // As it kills oursleves, we award XP to the damager 50 x Hit Dice.
                GiveXPToCreature(oDamager, 50 * GetHitDice(OBJECT_SELF));
                // Set ignore so to not be raised
                SetIgnore(OBJECT_SELF);
                // Finally apply death
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, OBJECT_SELF);
            }
        }
        break;
    }
}
