/************************ [On Spawn: High-Level Mage] **************************
    Filename: j_sp_highmage
************************* [On Spawn: High-Level Mage] **************************
    A mage who is higher level - ok, so it has many stuff from the default spawn
    file, but this one has some of the mage behaviours set, such as long range
    attacking and fast buffing, but no spell triggers.
************************* [On Spawn: High-Level Mage] *************************/

// This is required for all spawn in options!
#include "j_inc_spawnin"

void main()
{
    // Random intelligence, 7-9.
    SetAIInteger(AI_INTELLIGENCE, 6 + d3());
    SetAIInteger(AI_MORALE, 10);

    // Less mantals, and less saves is all we target
    AI_SetAITargetingValues(TARGETING_MANTALS, TARGET_LOWER, i1, i4);
    AI_SetAITargetingValues(TARGETING_SAVES, TARGET_LOWER, i1, i2);

    SetSpawnInCondition(AI_FLAG_COMBAT_PICK_UP_DISARMED_WEAPONS, AI_COMBAT_MASTER);
        // This sets to pick up weapons which are disarmed.
    SetAIInteger(AI_RANGED_WEAPON_RANGE, 2);
        // This is the range at which they go into melee (from using a ranged weapon). Default is 3 or 5.

    SetSpawnInCondition(AI_FLAG_COMBAT_DISPEL_IN_ORDER, AI_COMBAT_MASTER);

    SetSpawnInCondition(AI_FLAG_COMBAT_IMPROVED_INSTANT_DEATH_SPELLS, AI_COMBAT_MASTER);
    SetSpawnInCondition(AI_FLAG_COMBAT_FLAG_FAST_BUFF_ENEMY, AI_COMBAT_MASTER);
    SetSpawnInCondition(AI_FLAG_COMBAT_IMPROVED_SUMMON_TARGETING, AI_COMBAT_MASTER);
    SetSpawnInCondition(AI_FLAG_COMBAT_IMPROVED_IMMUNITY_CHECKING, AI_COMBAT_MASTER);
    SetSpawnInCondition(AI_FLAG_COMBAT_IMPROVED_SPECIFIC_SPELL_IMMUNITY, AI_COMBAT_MASTER);
    SetSpawnInCondition(AI_FLAG_COMBAT_LONGER_RANGED_SPELLS_FIRST, AI_COMBAT_MASTER);

    SetSpawnInCondition(AI_FLAG_OTHER_DONT_RESPOND_TO_EMOTES, AI_OTHER_MASTER);
        // This will ignore ALL chat by PC's (Enemies) who speak actions in Stars - *Bow*

    // no spells or items.
    SetSpawnInCondition(AI_FLAG_OTHER_LAG_NO_ITEMS, AI_OTHER_MASTER);
    SetSpawnInCondition(AI_FLAG_OTHER_LAG_NO_SPELLS, AI_OTHER_MASTER);

    // Ambient animations
    if(GetIsEncounterCreature())
    {
        SetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS, NW_GENERIC_MASTER);
    }

    AI_SetUpEndOfSpawn();
    DelayCommand(f2, SpawnWalkWayPoints());
}
