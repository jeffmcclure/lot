/************************ [User Defined: Alarm!] *******************************
    Filename: j_ude_damdie
************************* [User Defined: Alarm!] *******************************
    User defined event: Alarm!
************************* [History] ********************************************
    1.3 - Example of User Defined Event
************************* [Workings] *******************************************
    The NPC runs this as a pre-event On Heartbeat.

    Of course, this does't fire if they are fleeing or doing something like that.

    What happens, is that if the ALARM variable, set in the current area the NPC
    is in, is TRUE, then they will pre-buff themselves, arm weapons (if not already)
    and has a 50% chance of ActionRandomWalk.

    If it does the above, it stops the rest of the heartbeat firing.
************************* [User Defined: Alarm!] ******************************/

#include "j_inc_spawnin"

void main()
{
    // Get the user defined number.
    int iEvent = GetUserDefinedEventNumber();
    // Events.
    switch(iEvent)
    {
        // Event Damaged
        case EVENT_HEARTBEAT_PRE_EVENT:
        {
            // Make sure we are not in combat
            if(!GetIsInCombat())
            {
                // Is alarm variable set?
                if(GetLocalInt(GetArea(OBJECT_SELF), "ALARM") == TRUE)
                {
                    // We will buff if possible - as the other actions have
                    // a limited chance, this should fire after being set.
                    if(GetLocalInt(OBJECT_SELF, "DONE_BUFF") == FALSE)
                    {
                        SetLocalInt(OBJECT_SELF, "DONE_BUFF", TRUE);
                        SetSpawnInCondition(AI_FLAG_COMBAT_FLAG_FAST_BUFF_ENEMY, AI_COMBAT_MASTER);
                        // Buff first (this also equips weapons)
                        return;
                    }
                    if(d2() == TRUE)
                    {
                        // Move around 50% of the time
                        ClearAllActions();
                        ActionRandomWalk();

                        // Exit (Stop the rest of the script)
                        SetToExitFromUDE(EVENT_COMBAT_ACTION_PRE_EVENT);
                    }
                    // If the script gets here, fire heartbeat normally
                    return;
                }
            }
        }
        break;
    }
}
