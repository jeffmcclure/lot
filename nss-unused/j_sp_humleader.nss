/************************ [On Spawn: Human Leader] *****************************
    Filename: j_sp_humleader
************************* [On Spawn: Human Leader] *****************************
    A human leader sample spawn script.

    Maximum intelligence, some sample shouts/taunts and the leader  settings are
    on. He does, however, never run, and always likes melee.

    Shouldn't be a spellcaster, should only be a fighter primarily geared for HTH
    fighting.
************************* [On Spawn: Human Leader] ****************************/

// This is required for all spawn in options!
#include "j_inc_spawnin"

void main()
{
    // Maximum "intelligence"
    SetAIInteger(AI_INTELLIGENCE, 10);
    // We are fearless
    SetAIInteger(AI_MORALE, 10);

    AI_SetAITargetingValues(TARGETING_RANGE, TARGET_HIGHER, i2, i9);
    // Range - very imporant! Basis for all ranged/spell attacks.
    AI_SetAITargetingValues(TARGETING_AC, TARGET_LOWER, i2, i6);
    // AC is used for all phisical attacks. Lower targets lower (By default).
    // Fighter/Clerics (It is over a mages BAB + 1 (IE 0.5 BAB/Level) target lower
    AI_SetAITargetingValues(TARGETING_PHISICALS, TARGET_LOWER, i2, i6);
    // Base attack bonus. Used for spells and phisical attacks. Checked with GetBaseAttackBonus.
    AI_SetAITargetingValues(TARGETING_BAB, TARGET_LOWER, i1, i4);

    SetSpawnInCondition(AI_FLAG_FLEEING_FEARLESS, AI_TARGETING_FLEE_MASTER);
        // Forces them to not flee. This may be set with AI_SetMaybeFearless at the end.

    SetSpawnInCondition(AI_FLAG_COMBAT_PICK_UP_DISARMED_WEAPONS, AI_COMBAT_MASTER);
        // This sets to pick up weapons which are disarmed.

    SetAIInteger(AI_RANGED_WEAPON_RANGE, 6);
        // This is the range at which they go into melee (from using a ranged weapon). Default is 3 or 5.

    SetSpawnInCondition(AI_FLAG_COMBAT_BETTER_AT_HAND_TO_HAND, AI_COMBAT_MASTER);
        // Set if you want them to move forwards into HTH sooner. Will always
        // if the enemy is a mage/archer, else % based on range.

    // Set all leader variables
    SetSpawnInCondition(AI_FLAG_OTHER_COMBAT_GROUP_LEADER, AI_OTHER_COMBAT_MASTER);
        // Special leader. Can issuse some orders. See readme for details.
    SetSpawnInCondition(AI_FLAG_OTHER_COMBAT_BOSS_MONSTER_SHOUT, AI_OTHER_COMBAT_MASTER);
        // Boss shout. 1 time use - calls all creatures in X meters (below) for battle!
    //SetAIInteger(AI_BOSS_MONSTER_SHOUT_RANGE, 60);
        // Defaults to a 60 M range. This can change it. Note: 1 toolset square = 10M.


    SetSpawnInCondition(AI_FLAG_OTHER_NO_POLYMORPHING, AI_OTHER_MASTER);
        // This will stop all polymorphing spells feats from being used.
    SetSpawnInCondition(AI_FLAG_OTHER_DONT_RESPOND_TO_EMOTES, AI_OTHER_MASTER);
        // This will ignore ALL chat by PC's (Enemies) who speak actions in Stars - *Bow*

    SetSpawnInCondition(AI_FLAG_OTHER_REST_AFTER_COMBAT, AI_OTHER_MASTER);
        // When combat is over, creature rests. Useful for replenising health.
    SetSpawnInCondition(AI_FLAG_OTHER_NO_PLAYING_VOICE_CHAT, AI_OTHER_MASTER);

    // Can uncomment these if the leader has no spells or items.
    //SetSpawnInCondition(AI_FLAG_OTHER_LAG_NO_ITEMS, AI_OTHER_MASTER);
        // The creature doesn't check for, or use any items that cast spells.
    //SetSpawnInCondition(AI_FLAG_OTHER_LAG_NO_SPELLS, AI_OTHER_MASTER);
        //The creature doesn't ever cast spells (and never checks them)

    // Combat
    AI_SetSpawnInSpeakArray(AI_TALK_ON_COMBAT_ROUND_EQUAL, 10, 4, "You don't stand a chance!", "Men, Attack!", "For Glory!!", "Eat steel!");
    AI_SetSpawnInSpeakArray(AI_TALK_ON_COMBAT_ROUND_THEM_OVER_US, 10, 4, "Your might is no match for my brains!", "Tough man, are we?", "You won't kill me!", "Pah! I am no coward! I fight on!");
    AI_SetSpawnInSpeakArray(AI_TALK_ON_COMBAT_ROUND_US_OVER_THEM, 10, 4, "No mercy!", "Hope for a quick death!", "Men! Kill the lot!", "There is no chance!");

    // Our leader shouts!
    // - As this is a human, very orderly
    AI_SetSpawnInSpeakValue(AI_TALK_ON_LEADER_SEND_RUNNER, "Soldier! Go find help!");
    AI_SetSpawnInSpeakValue(AI_TALK_ON_LEADER_ATTACK_TARGET, "Direct your attacks here, men!");

    // Ambient animations
    if(GetIsEncounterCreature())
    {
        SetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS, NW_GENERIC_MASTER);
    }

    AI_SetUpEndOfSpawn();
    DelayCommand(f2, SpawnWalkWayPoints());
}
