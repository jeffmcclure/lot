#include "nw_i0_generic"
void main()
{

object oPC = GetLastUsedBy();
if (!GetIsPC(oPC)) return;
int DoOnce = GetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF));
if (DoOnce==TRUE) return;
SetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF), TRUE);

object oTarget;
oTarget = oPC;

//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead

int nInt;
nInt = GetObjectType(oTarget);

if (nInt != OBJECT_TYPE_WAYPOINT) ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_UNSUMMON), oTarget);
else ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_UNSUMMON), GetLocation(oTarget));

object oCaster;
oCaster = OBJECT_SELF;
oTarget = oPC;
AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_BLINDNESS_AND_DEAFNESS, oTarget, METAMAGIC_ANY, TRUE, 1, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));

oCaster = OBJECT_SELF;
oTarget = oPC;
AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_DARKNESS, oTarget, METAMAGIC_ANY, TRUE, 1, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));

object oSpawn;
location lTarget;

oTarget = oPC;
lTarget = GetLocation(oTarget);
oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "hiddenskelly", lTarget);
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

oTarget = oPC;
lTarget = GetLocation(oTarget);
oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "hiddenskelly", lTarget);
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

FloatingTextStringOnCreature("What you can't see, WILL hurt you...", oPC);

DelayCommand(8.0, ExecuteScript("rdm_shrine1c", OBJECT_SELF));
oTarget = OBJECT_SELF;
DelayCommand(10.0, DestroyObject(oTarget, 0.0));

}

