/************************ [On Spawn: Archer] ***********************************
    Filename: j_sp_archer
************************* [On Spawn: Archer] ***********************************
    Any-level archer. This man is pretty basic, and has really only the special
    archery stuff on.
************************* [On Spawn: Archer] **********************************/

// This is required for all spawn in options!
#include "j_inc_spawnin"

void main()
{
    // Random intelligence, 4-6.
    SetAIInteger(AI_INTELLIGENCE, 3 + d3());
    // Random morale
    SetAIInteger(AI_MORALE, 7 + d6());

    AI_SetAITargetingValues(TARGETING_RANGE, TARGET_HIGHER, i2, i9);
    // Range - very imporant! Basis for all ranged/spell attacks.

    SetSpawnInCondition(AI_FLAG_COMBAT_PICK_UP_DISARMED_WEAPONS, AI_COMBAT_MASTER);
        // This sets to pick up weapons which are disarmed.
    SetAIInteger(AI_RANGED_WEAPON_RANGE, 2);
        // This is the range at which they go into melee (from using a ranged weapon). Default is 3 or 5.

    SetSpawnInCondition(AI_FLAG_COMBAT_ARCHER_ATTACKING, AI_COMBAT_MASTER);
        // For archers. If they have ally support, they'd rather move back & shoot then go into HTH.
    SetSpawnInCondition(AI_FLAG_COMBAT_ARCHER_ALWAYS_MOVE_BACK, AI_COMBAT_MASTER);
        // This forces the move back from attackers, and shoot bows. Very small chance to go melee.
    //SetSpawnInCondition(AI_FLAG_COMBAT_ARCHER_ALWAYS_USE_BOW, AI_COMBAT_MASTER);
        // This will make the creature ALWAYs use any bows it has. ALWAYS.

    SetSpawnInCondition(AI_FLAG_OTHER_NO_POLYMORPHING, AI_OTHER_MASTER);
        // This will stop all polymorphing spells feats from being used.
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
