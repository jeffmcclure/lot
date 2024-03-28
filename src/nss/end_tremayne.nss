#include "nw_i0_generic"
void main()
{

object oPC = GetPCSpeaker();
AddJournalQuestEntry("QST_SHADOWFANG", 3, oPC, TRUE, FALSE);

object oTarget;
oTarget = GetObjectByTag("TREMAYNE");

//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead

int nInt;
nInt = GetObjectType(oTarget);

if (nInt != OBJECT_TYPE_WAYPOINT) ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DEATH), oTarget);
else ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DEATH), GetLocation(oTarget));

oTarget = GetObjectByTag("TREMAYNE");
DestroyObject(oTarget, 3.0);

object oSpawn;
location lTarget;
oTarget = oPC;

lTarget = GetLocation(oTarget);

oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "cursedtremayne", lTarget);

oTarget = oSpawn;

SetIsTemporaryEnemy(oPC, oTarget);
AssignCommand(oTarget, ActionAttack(oPC));
AssignCommand(oTarget, DetermineCombatRound(oPC));

oTarget = oSpawn;

//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead

nInt = GetObjectType(oTarget);

if (nInt != OBJECT_TYPE_WAYPOINT) DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_IMPLOSION), oTarget));
else DelayCommand(0.5, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_IMPLOSION), GetLocation(oTarget)));

}

