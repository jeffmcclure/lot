// Herbivore
// - Always runs. Doesn't open doors. Animations.

#include "j_inc_spawnin"

void main()
{
    SetAIInteger(AI_MORALE, -1);
        // Always run

    SetSpawnInCondition(AI_FLAG_OTHER_DONT_RESPOND_TO_EMOTES, AI_OTHER_MASTER);
        // This will ignore ALL chat by ENEMIES who speak in Stars - IE
        // "*Nods*" will be ignored, while "Nods" will not, nor "*Nods"

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
