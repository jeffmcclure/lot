void main()
{

object oPC = GetPCSpeaker();

object oTarget;
oTarget = OBJECT_SELF;

//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead

int nInt;
nInt = GetObjectType(oTarget);

if (nInt != OBJECT_TYPE_WAYPOINT) ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DEATH), oTarget);
else ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DEATH), GetLocation(oTarget));

oTarget = OBJECT_SELF;
DestroyObject(oTarget, 3.0);

}
