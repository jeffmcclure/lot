// Spawn in default for omnivores.
// Omnivore script, no opening doors, random walking. Fearless

#include "j_inc_spawnin"

void main()
{
    SetAIInteger(AI_INTELLIGENCE, 10);
        // This is the intelligence of the creature 1-10. Default to 10
        // Read the file in "Explainations" about this intelligence for more info.

    SetSpawnInCondition(AI_FLAG_FLEEING_FEARLESS, AI_TARGETING_FLEE_MASTER);
        // This will make the creature never flee at all.
        // This ONLY AFFECTS MORALE! Here, uncommented by default. :-)
        // Note: This is set if we are Immune by item/feat/fearless race, at the end of spawn

    SetAIInteger(AI_DOOR_INTELLIGENCE, 2);
        // This will determine what to do with blocking doors. Default is 0 or not set, which
        // means intelligence will take the key, and they may unlock, untrap, knock or bash it.
        // 1 = Always bashes the door (does not check for plot flag, or if it can be opened).
        // 2 = Never open any doors (none! Just stops there)
        // 3 = Never attempts to open (bash or anything) plot doors

    SetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS, NW_GENERIC_MASTER);
        // Animations

    // AI Behaviour. DO NOT CHANGE! DO NOT CHANGE!!!
    AI_SetUpEndOfSpawn();
        // This MUST be called. It fires these events:
        // SetUpSpells, SetUpSkillToUse, SetListeningPatterns, SetWeapons, AdvancedAuras.
        // These MUST be called! the AI might fail to work correctly if they don't fire!

    // Note: You shouldn't really remove this. Also performs hiding ETC.
    DelayCommand(f2, SpawnWalkWayPoints());
        // Delayed walk waypoints, as to not upset instant combat spawning.
        // This will also check if to change to day/night posts during the walking, no heartbeats.
}
