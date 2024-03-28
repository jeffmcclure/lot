#include "nw_i0_generic"
void main()
{

object oPC = GetEnteringObject();

//object oTarget;
//oTarget = OBJECT_SELF;
//ChangeToStandardFaction(oTarget, STANDARD_FACTION_HOSTILE);
//SetIsTemporaryEnemy(GetPCSpeaker());
//DetermineCombatRound();

object oTarget;
object oSpawn;
location lTarget;
oTarget = GetWaypointByTag("WP_CRINOSTRAP1");
lTarget = GetLocation(oTarget);
oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "werewolf002", lTarget);
oTarget = oSpawn;
SetIsTemporaryEnemy(oPC, oTarget);
AssignCommand(oTarget, ActionAttack(oPC));
AssignCommand(oTarget, DetermineCombatRound(oPC));

oTarget = oSpawn;
//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead
int nInt;
nInt = GetObjectType(oTarget);
if (nInt != OBJECT_TYPE_WAYPOINT) DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_POLYMORPH), oTarget));
else DelayCommand(0.5, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_POLYMORPH), GetLocation(oTarget)));
oTarget = GetWaypointByTag("WP_CRINOSTRAP1");
lTarget = GetLocation(oTarget);
oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "werewolf002", lTarget);
oTarget = oSpawn;
SetIsTemporaryEnemy(oPC, oTarget);
AssignCommand(oTarget, ActionAttack(oPC));
AssignCommand(oTarget, DetermineCombatRound(oPC));

oTarget = oSpawn;
//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead
nInt = GetObjectType(oTarget);
if (nInt != OBJECT_TYPE_WAYPOINT) DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_POLYMORPH), oTarget));
else DelayCommand(0.5, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_POLYMORPH), GetLocation(oTarget)));
oTarget = GetWaypointByTag("WP_CRINOSTRAP2");
lTarget = GetLocation(oTarget);
oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "werewolf002", lTarget);
oTarget = oSpawn;
SetIsTemporaryEnemy(oPC, oTarget);
AssignCommand(oTarget, ActionAttack(oPC));
AssignCommand(oTarget, DetermineCombatRound(oPC));

oTarget = oSpawn;
//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead
nInt = GetObjectType(oTarget);
if (nInt != OBJECT_TYPE_WAYPOINT) DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_POLYMORPH), oTarget));
else DelayCommand(0.5, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_POLYMORPH), GetLocation(oTarget)));
oTarget = GetWaypointByTag("WP_CRINOSTRAP2");
lTarget = GetLocation(oTarget);
oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "werewolf002", lTarget);
oTarget = oSpawn;
SetIsTemporaryEnemy(oPC, oTarget);
AssignCommand(oTarget, ActionAttack(oPC));
AssignCommand(oTarget, DetermineCombatRound(oPC));

oTarget = oSpawn;
//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead
nInt = GetObjectType(oTarget);
if (nInt != OBJECT_TYPE_WAYPOINT) DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_POLYMORPH), oTarget));
else DelayCommand(0.5, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_POLYMORPH), GetLocation(oTarget)));
oTarget = GetWaypointByTag("WP_CRINOSTRAP2");
lTarget = GetLocation(oTarget);
oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "werewolf002", lTarget);
oTarget = oSpawn;
SetIsTemporaryEnemy(oPC, oTarget);
AssignCommand(oTarget, ActionAttack(oPC));
AssignCommand(oTarget, DetermineCombatRound(oPC));

}
