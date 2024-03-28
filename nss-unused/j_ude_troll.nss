/************************ [User Defined: Troll] ********************************
    Filename: j_ude_troll
************************* [User Defined: Troll] ********************************
    User defined event: Troll.
************************* [History] ********************************************
    1.3 - Example of User Defined Event
************************* [Workings] *******************************************
    This will:

    - On Damaged, lower the amount we can regenerate by the amount of fire
      or acid damage we can take
    - On Death, if we can revive ourselves (Because we have not taken our max
      HP damage in fire or acid damage) then we do after 2 rounds.
    - On Heartbeat, we regnerate 5HP, up to the damage we have no got in acid/fire
      damage

    Ideas:

    - Have all regeneration stop on damage by fire and acid (and stop raising)
    - Change for different creatures and different damage types
    - Broaden so that, say, damage actually heals the creature (heals double
      what was recieved by that damage type)
************************* [User Defined: Troll] *******************************/

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
        // Event Heartbeat
        // Arguments: Basically, none. Nothing activates this script. Fires every 6 seconds.
        case EVENT_HEARTBEAT_PRE_EVENT:
        {
            int iDamageRecieved = GetLocalInt(OBJECT_SELF, "TROLL_DAMAGE_RECIEVED");
            int iMax = GetMaxHitPoints();
            int iCurrent = GetCurrentHitPoints();
            // This fires before the rest of the On Heartbeat file does
            if(iDamageRecieved < iMax)
            {
                // Heal self as long as we have less current hit points then
                // max damage - recieved.
                if(iCurrent < (iMax - iDamageRecieved))
                {
                    // Regenerate
                    int iRegenamount = iMax - iDamageRecieved;
                    if(iRegenamount > 5) iRegenamount = 5;
                    // Heal
                    effect eRegerate = EffectHeal(iRegenamount);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eRegerate, OBJECT_SELF);
                }
            }
            // Never exit.
        }
        break;

        // Event Damaged
        // Arguments: GetTotalDamageDealt, GetLastDamager, GetCurrentHitPoints
        // (and max),  GetDamageDealtByType (must be done seperatly for each,
        // doesn't count  melee damage)
        case EVENT_DAMAGED_PRE_EVENT:
        {
            // Add acid and fire damage to damage recieved
            int iDamageRecieved = GetLocalInt(OBJECT_SELF, "TROLL_DAMAGE_RECIEVED");
            // Acid + fire
            int iAcid = GetDamageDealtByType(DAMAGE_TYPE_ACID);
            int iFire = GetDamageDealtByType(DAMAGE_TYPE_FIRE);

            // Add it to it
            iDamageRecieved = iDamageRecieved + iAcid + iFire;
            // Set it
            SetLocalInt(OBJECT_SELF, "TROLL_DAMAGE_RECIEVED", iDamageRecieved);
        }
        break;

        // Event Death
        // Arguments: GetLastKiller
        case EVENT_DEATH_PRE_EVENT:
        {
            int iDamageRecieved = GetLocalInt(OBJECT_SELF, "TROLL_DAMAGE_RECIEVED");
            int iMax = GetMaxHitPoints();
            // Die - we will regen in 2 rounds
            if(iDamageRecieved < iMax)
            {
                // 2 rounds until regen + 1/6th of HP
                effect eRaise = EffectResurrection();
                effect eHP = EffectHeal(iMax/6);
                DelayCommand(12.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eRaise, OBJECT_SELF));
                DelayCommand(12.1, ApplyEffectToObject(DURATION_TYPE_INSTANT, eHP, OBJECT_SELF));
                // Exit the UDE as we shouldn't give XP
                SetToExitFromUDE(EVENT_DEATH_PRE_EVENT);
            }
        }
        break;
    }
}
