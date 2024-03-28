#include "NW_I0_GENERIC"
#include "inc_party"
void main()
{

object oPC = GetPCSpeaker();

object oTarget;
oTarget = OBJECT_SELF;
ChangeToStandardFaction(oTarget, STANDARD_FACTION_HOSTILE);
SetIsTemporaryEnemy(oPC, oTarget);
AssignCommand(oTarget, ActionAttack(oPC));
AssignCommand(oTarget, DetermineCombatRound(oPC));
SetPartyInt(oPC, "ogdensign", 1);

oTarget = GetObjectByTag("DOOR_SNOTSPILL");
SetLocked(oTarget, FALSE);
AssignCommand(oTarget, ActionOpenDoor(oTarget));

oTarget = GetObjectByTag("DOOR_SNOTSPILL1");
SetLocked(oTarget, FALSE);
AssignCommand(oTarget, ActionOpenDoor(oTarget));

oTarget = GetObjectByTag("DOOR_SNOTSPILL2");
SetLocked(oTarget, FALSE);
AssignCommand(oTarget, ActionOpenDoor(oTarget));

object oSpawn;
location lTarget;

oTarget = GetWaypointByTag("WP_SNOTSPILL_01");
lTarget = GetLocation(oTarget);
oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "fallenone004", lTarget);
oTarget = oSpawn;
SetIsTemporaryEnemy(oPC, oTarget);
AssignCommand(oTarget, ActionAttack(oPC));
AssignCommand(oTarget, DetermineCombatRound(oPC));

oTarget = GetWaypointByTag("WP_SNOTSPILL_02");
lTarget = GetLocation(oTarget);
oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "fallenone004", lTarget);
oTarget = oSpawn;
SetIsTemporaryEnemy(oPC, oTarget);
AssignCommand(oTarget, ActionAttack(oPC));
AssignCommand(oTarget, DetermineCombatRound(oPC));

oTarget = GetWaypointByTag("WP_SNOTSPILL_03");
lTarget = GetLocation(oTarget);
oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "fallenone004", lTarget);
oTarget = oSpawn;
SetIsTemporaryEnemy(oPC, oTarget);
AssignCommand(oTarget, ActionAttack(oPC));
AssignCommand(oTarget, DetermineCombatRound(oPC));

oTarget = GetWaypointByTag("WP_SNOTSPILL_04");
lTarget = GetLocation(oTarget);
oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "fallenonebrute", lTarget);
oTarget = oSpawn;
SetIsTemporaryEnemy(oPC, oTarget);
AssignCommand(oTarget, ActionAttack(oPC));
AssignCommand(oTarget, DetermineCombatRound(oPC));

oTarget = GetWaypointByTag("WP_SNOTSPILL_05");
lTarget = GetLocation(oTarget);
oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "fallenone004", lTarget);
oTarget = oSpawn;
SetIsTemporaryEnemy(oPC, oTarget);
AssignCommand(oTarget, ActionAttack(oPC));
AssignCommand(oTarget, DetermineCombatRound(oPC));

oTarget = GetWaypointByTag("WP_SNOTSPILL_06");
lTarget = GetLocation(oTarget);
oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "fallenone004", lTarget);
oTarget = oSpawn;
SetIsTemporaryEnemy(oPC, oTarget);
AssignCommand(oTarget, ActionAttack(oPC));
AssignCommand(oTarget, DetermineCombatRound(oPC));

oTarget = GetWaypointByTag("WP_SNOTSPILL_07");
lTarget = GetLocation(oTarget);
oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "fallenone004", lTarget);
oTarget = oSpawn;
SetIsTemporaryEnemy(oPC, oTarget);
AssignCommand(oTarget, ActionAttack(oPC));
AssignCommand(oTarget, DetermineCombatRound(oPC));

oTarget = GetWaypointByTag("WP_SNOTSPILL_08");
lTarget = GetLocation(oTarget);
oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "fallenonebrute2", lTarget);
oTarget = oSpawn;
SetIsTemporaryEnemy(oPC, oTarget);
AssignCommand(oTarget, ActionAttack(oPC));
AssignCommand(oTarget, DetermineCombatRound(oPC));

oTarget = GetWaypointByTag("WP_SNOTSPILL_09");
lTarget = GetLocation(oTarget);
oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "fallenone006", lTarget);
oTarget = oSpawn;
SetIsTemporaryEnemy(oPC, oTarget);
AssignCommand(oTarget, ActionAttack(oPC));
AssignCommand(oTarget, DetermineCombatRound(oPC));

oTarget = GetWaypointByTag("WP_SNOTSPILL_10");
lTarget = GetLocation(oTarget);
oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "fallenone007", lTarget);
oTarget = oSpawn;
SetIsTemporaryEnemy(oPC, oTarget);
AssignCommand(oTarget, ActionAttack(oPC));
AssignCommand(oTarget, DetermineCombatRound(oPC));

oTarget = GetWaypointByTag("WP_SNOTSPILL_11");
lTarget = GetLocation(oTarget);
oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "fallenone007", lTarget);
oTarget = oSpawn;
SetIsTemporaryEnemy(oPC, oTarget);
AssignCommand(oTarget, ActionAttack(oPC));
AssignCommand(oTarget, DetermineCombatRound(oPC));

oTarget = GetWaypointByTag("WP_SNOTSPILL_12");
lTarget = GetLocation(oTarget);
oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "fallenonebrute", lTarget);
oTarget = oSpawn;
SetIsTemporaryEnemy(oPC, oTarget);
AssignCommand(oTarget, ActionAttack(oPC));
AssignCommand(oTarget, DetermineCombatRound(oPC));

oTarget = GetWaypointByTag("WP_SNOTSPILL_13");
lTarget = GetLocation(oTarget);
oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "fallenonebrute", lTarget);
oTarget = oSpawn;
SetIsTemporaryEnemy(oPC, oTarget);
AssignCommand(oTarget, ActionAttack(oPC));
AssignCommand(oTarget, DetermineCombatRound(oPC));

oTarget = GetWaypointByTag("WP_SNOTSPILL_14");
lTarget = GetLocation(oTarget);
oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "fallenonebrute2", lTarget);
oTarget = oSpawn;
SetIsTemporaryEnemy(oPC, oTarget);
AssignCommand(oTarget, ActionAttack(oPC));
AssignCommand(oTarget, DetermineCombatRound(oPC));

AddJournalQuestEntry("QST_MAGICBANNER", 3, oPC, TRUE, FALSE);

}

