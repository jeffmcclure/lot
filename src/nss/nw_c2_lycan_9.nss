// Lycanthorpe spawn in file.
// - On attacked event. Fearless.

#include "j_inc_spawnin"

void main()
{
    SetAIInteger(AI_INTELLIGENCE, 10);
        // This is the intelligence of the creature 1-10. Default to 10
        // Read the file in "Explainations" about this intelligence for more info.

    SetSpawnInCondition(AI_FLAG_FLEEING_FEARLESS, AI_TARGETING_FLEE_MASTER);
        // Fearless

    SetSpawnInCondition(AI_FLAG_OTHER_DONT_RESPOND_TO_EMOTES, AI_OTHER_MASTER);
        // This will ignore ALL chat by ENEMIES who speak in Stars - IE
        // "*Nods*" will be ignored, while "Nods" will not, nor "*Nods"

    SetSpawnInCondition(AI_FLAG_UDE_ATTACK_EVENT, AI_UDE_MASTER);

    // AI Behaviour. DO NOT CHANGE! DO NOT CHANGE!!!
    AI_SetUpEndOfSpawn();
        // This MUST be called. It fires these events:
        // SetUpSpells, SetUpSkillToUse, SetListeningPatterns, SetWeapons, AdvancedAuras.
        // These MUST be called! the AI might fail to work correctly if they don't fire!

    // Example (and default) of user addition:
    // - If we are from an encounter, set mobile (move around) animations.
    if(GetIsEncounterCreature())
    {
        SetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS, NW_GENERIC_MASTER);
    }

    // Note: You shouldn't really remove this. Also performs hiding ETC.
    DelayCommand(f2, SpawnWalkWayPoints());
        // Delayed walk waypoints, as to not upset instant combat spawning.
        // This will also check if to change to day/night posts during the walking, no heartbeats.
}
