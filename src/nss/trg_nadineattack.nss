#include "inc_party"
#include "nw_i0_generic"
void main()
{

object oPC = GetPCSpeaker();

object oTarget;
oTarget = GetObjectByTag("NADINE");
DestroyObject(oTarget, 0.0);

object oSpawn;
location lTarget;
oTarget = oPC;
lTarget = GetLocation(oTarget);
oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "nadinetemptress", lTarget);
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

oTarget = oSpawn;
//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead
nInt = GetObjectType(oTarget);
if (nInt != OBJECT_TYPE_WAYPOINT) DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_POLYMORPH), oTarget));
else DelayCommand(0.5, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_POLYMORPH), GetLocation(oTarget)));
oTarget = GetWaypointByTag("WP_NADINE_AMBUSH_01");
lTarget = GetLocation(oTarget);
oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "temptress", lTarget);
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
oTarget = GetWaypointByTag("WP_NADINE_AMBUSH_02");
lTarget = GetLocation(oTarget);
oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "temptress", lTarget);
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
oTarget = GetWaypointByTag("WP_NADINE_AMBUSH_03");
lTarget = GetLocation(oTarget);
oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "temptress", lTarget);
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
oTarget = GetWaypointByTag("WP_NADINE_AMBUSH_04");
lTarget = GetLocation(oTarget);
oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "temptress", lTarget);
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
oTarget = GetWaypointByTag("WP_NADINE_AMBUSH_05");
lTarget = GetLocation(oTarget);
oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "temptress", lTarget);
oTarget = oSpawn;
SetIsTemporaryEnemy(oPC, oTarget);
AssignCommand(oTarget, ActionAttack(oPC));
AssignCommand(oTarget, DetermineCombatRound(oPC));


SetPartyInt(oPC, "nadine", 3);

}
