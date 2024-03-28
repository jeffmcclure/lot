/************************ [On Spawn: Dragon] ***********************************
    Filename: j_sp_dragon
************************* [On Spawn: Dragon] ***********************************
    Dragons are highly intelligent, and can...fly!

    They do have a few improved spellcasting bits, and like to target lower AC
    more then anything.

    Flying is also on, so they can jump to enemies far away.
************************* [On Spawn: Dragon] **********************************/

// This is required for all spawn in options!
#include "j_inc_spawnin"

void main()
{
    // Maximum "intelligence"
    SetAIInteger(AI_INTELLIGENCE, 10);
    SetAIInteger(AI_MORALE, 10);

    AI_SetAITargetingValues(TARGETING_RANGE, TARGET_HIGHER, i2, i9);
    AI_SetAITargetingValues(TARGETING_AC, TARGET_LOWER, i1, i6);

    SetSpawnInCondition(AI_FLAG_COMBAT_FLAG_FAST_BUFF_ENEMY, AI_COMBAT_MASTER);
    SetSpawnInCondition(AI_FLAG_COMBAT_IMPROVED_INSTANT_DEATH_SPELLS, AI_COMBAT_MASTER);
    SetSpawnInCondition(AI_FLAG_COMBAT_IMPROVED_IMMUNITY_CHECKING, AI_COMBAT_MASTER);
    SetSpawnInCondition(AI_FLAG_COMBAT_IMPROVED_SPECIFIC_SPELL_IMMUNITY, AI_COMBAT_MASTER);
    SetSpawnInCondition(AI_FLAG_COMBAT_LONGER_RANGED_SPELLS_FIRST, AI_COMBAT_MASTER);

    SetSpawnInCondition(AI_FLAG_OTHER_DONT_RESPOND_TO_EMOTES, AI_OTHER_MASTER);
        // This will ignore ALL chat by PC's (Enemies) who speak actions in Stars - *Bow*

    // Dragon stuff
    SetSpawnInCondition(AI_FLAG_COMBAT_FLYING, AI_COMBAT_MASTER);

    AI_SetUpEndOfSpawn();
    DelayCommand(f2, SpawnWalkWayPoints());
}
