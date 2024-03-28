//#include "nw_i0_generic"
void main()
{

object oPC = GetPCSpeaker();

object oTarget;
oTarget = GetObjectByTag("TREMAYNE");

//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead

int nInt;
nInt = GetObjectType(oTarget);

if (nInt != OBJECT_TYPE_WAYPOINT) ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_DUR_INFERNO), oTarget);
else ApplyEffectAtLocation(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_INFERNO), GetLocation(oTarget));

oTarget = GetObjectByTag("TREMAYNE");

//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead

nInt = GetObjectType(oTarget);

if (nInt != OBJECT_TYPE_WAYPOINT) ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_FIREBALL), oTarget);
else ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_FIREBALL), GetLocation(oTarget));

oTarget = GetObjectByTag("TREMAYNE");

//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead

nInt = GetObjectType(oTarget);

if (nInt != OBJECT_TYPE_WAYPOINT) ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DESTRUCTION), oTarget);
else ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DESTRUCTION), GetLocation(oTarget));

oTarget = GetObjectByTag("HELL3_2HELLFORGE");
SetLocked(oTarget, FALSE);
AssignCommand(oTarget, ActionOpenDoor(oTarget));

}
