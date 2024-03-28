/************************ [On Spawn: Lich] *************************************
    Filename: j_sp_lichboss
************************* [On Spawn: Lich] *************************************
    A high-powered lich, who takes advantage of spell triggers!

    He should be geared towards higher level spells, and once he runs out, he
    does cheat-cast several 1-3 level spells.

    The spell triggers stop quite a bit of damage, with Premonition, greater
    spell mantal and Energy Buffer. He also has some taunts he uses most combat
    rounds, as well as using longer ranged spells first.

    As he is a boss, he is a leader status, and also gets a free harm at 30% HP.
************************* [On Spawn: Lich] ************************************/

// This is required for all spawn in options!
#include "j_inc_spawnin"

void main()
{
    // Maximum intelligence
    SetAIInteger(AI_INTELLIGENCE, 10);
    SetAIInteger(AI_MORALE, 10);
    SetSpawnInCondition(AI_FLAG_FLEEING_FEARLESS, AI_TARGETING_FLEE_MASTER);

    SetSpawnInCondition(AI_FLAG_OTHER_DONT_RESPOND_TO_EMOTES, AI_OTHER_MASTER);

    AI_SetAITargetingValues(TARGETING_MANTALS, TARGET_LOWER, i1, i12);
    AI_SetAITargetingValues(TARGETING_RANGE, TARGET_HIGHER, i2, i9);
    AI_SetAITargetingValues(TARGETING_AC, TARGET_LOWER, i3, i6);
    AI_SetAITargetingValues(TARGETING_SAVES, TARGET_LOWER, i3, i4);
    // Mages target higher. (the lowest BAB, under half our hit dice in BAB)
    AI_SetAITargetingValues(TARGETING_PHISICALS, TARGET_HIGHER, i1, i5);

    AI_SetAITargetingValues(TARGETING_BAB, TARGET_LOWER, i1, i4);
    AI_SetAITargetingValues(TARGETING_HITDICE, TARGET_LOWER, i1, i3);

    SetSpawnInCondition(AI_FLAG_COMBAT_DISPEL_IN_ORDER, AI_COMBAT_MASTER);

    SetSpawnInCondition(AI_FLAG_COMBAT_IMPROVED_INSTANT_DEATH_SPELLS, AI_COMBAT_MASTER);
    SetSpawnInCondition(AI_FLAG_COMBAT_IMPROVED_SUMMON_TARGETING, AI_COMBAT_MASTER);
    SetSpawnInCondition(AI_FLAG_COMBAT_IMPROVED_IMMUNITY_CHECKING, AI_COMBAT_MASTER);
    SetSpawnInCondition(AI_FLAG_COMBAT_IMPROVED_SPECIFIC_SPELL_IMMUNITY, AI_COMBAT_MASTER);
    SetSpawnInCondition(AI_FLAG_OTHER_COMBAT_WILL_RAISE_ALLIES_IN_BATTLE, AI_OTHER_COMBAT_MASTER);

    SetSpawnInCondition(AI_FLAG_OTHER_COMBAT_GROUP_LEADER, AI_OTHER_COMBAT_MASTER);

    SetSpawnInCondition(AI_FLAG_COMBAT_LONGER_RANGED_SPELLS_FIRST, AI_COMBAT_MASTER);

    AI_SetSpawnInSpeakArray(AI_TALK_ON_COMBAT_ROUND_EQUAL, 900, 4, "Curse your life!", "Nothing can kill the undead!", "MUhahaHaHahahha!!", "Prepare to DIE!");
    AI_SetSpawnInSpeakArray(AI_TALK_ON_COMBAT_ROUND_THEM_OVER_US, 900, 4, "Curse your life!", "Nothing can kill the undead!", "MUhahaHaHahahha!!", "Prepare to DIE!");
    AI_SetSpawnInSpeakArray(AI_TALK_ON_COMBAT_ROUND_US_OVER_THEM, 900, 4, "Curse your life!", "Nothing can kill the undead!", "MUhahaHaHahahha!!", "Prepare to DIE!");

    // Spell triggers
    SetSpellTrigger(SPELLTRIGGER_START_OF_COMBAT, FALSE, 1, SPELL_DEATH_ARMOR, SPELL_FOXS_CUNNING, SPELL_SHADOW_SHIELD);

    // Damamged
    SetSpellTrigger(SPELLTRIGGER_DAMAGED_AT_PERCENT, 30, 1, SPELL_HARM);

    // Immobile
    SetSpellTrigger(SPELLTRIGGER_IMMOBILE, FALSE, 1, SPELL_FREEDOM_OF_MOVEMENT);

    // Normal defensive
    SetSpellTrigger(SPELLTRIGGER_NOT_GOT_FIRST_SPELL, FALSE, 1, SPELL_PREMONITION);
    SetSpellTrigger(SPELLTRIGGER_NOT_GOT_FIRST_SPELL, FALSE, 2, SPELL_PREMONITION);
    SetSpellTrigger(SPELLTRIGGER_NOT_GOT_FIRST_SPELL, FALSE, 3, SPELL_GREATER_SPELL_MANTLE);
    SetSpellTrigger(SPELLTRIGGER_NOT_GOT_FIRST_SPELL, FALSE, 4, SPELL_GREATER_SPELL_MANTLE);
    SetSpellTrigger(SPELLTRIGGER_NOT_GOT_FIRST_SPELL, FALSE, 5, SPELL_ENERGY_BUFFER);
    SetSpellTrigger(SPELLTRIGGER_NOT_GOT_FIRST_SPELL, FALSE, 6, SPELL_ENERGY_BUFFER);

    // Cheat spells
    SetAICheatCastSpells(SPELL_MAGIC_MISSILE, SPELL_MAGIC_MISSILE, SPELL_MAGIC_MISSILE, SPELL_FIREBALL, SPELL_MELFS_ACID_ARROW, SPELL_MELFS_ACID_ARROW);

    AI_SetUpEndOfSpawn();
    DelayCommand(2.0, SpawnWalkWayPoints());
}
