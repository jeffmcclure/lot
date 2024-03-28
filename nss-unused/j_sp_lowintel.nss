/************************ [On Spawn: Low Intelligence] *************************
    Filename: j_sp_lowintel
************************* [On Spawn: Low Intelligence] *************************
    Low intelligence creatures, such as Goblins, might not have an advanced a
    way of picking who to best attack, nor as much AI intelligence.
************************* [On Spawn: Low Intelligence] ************************/

// This is required for all spawn in options!
#include "j_inc_spawnin"

void main()
{
    // 1 or 2 intelligence.
    SetAIInteger(AI_INTELLIGENCE, d2());
    SetAIInteger(AI_MORALE, 10);

    // Probably worse for the AI to have these set - acts less intelligently.
    SetSpawnInCondition(AI_FLAG_OTHER_LAG_EQUIP_MOST_DAMAGING, AI_OTHER_MASTER);
    SetSpawnInCondition(AI_FLAG_OTHER_LAG_TARGET_NEAREST_ENEMY, AI_OTHER_MASTER);

    // Lots of other stuff is affected by having 1 or 2 intelligence anyway.
    // Removed a few of the immunity-checking bits, to lower effectivness.

    SetSpawnInCondition(AI_FLAG_OTHER_DONT_RESPOND_TO_EMOTES, AI_OTHER_MASTER);
        // This will ignore ALL chat by PC's (Enemies) who speak actions in Stars - *Bow*

    AI_SetUpEndOfSpawn();
    DelayCommand(f2, SpawnWalkWayPoints());
}
