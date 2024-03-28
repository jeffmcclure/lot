void main()
{

object oTarget;
oTarget = OBJECT_SELF;

//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead

int nInt;
nInt = GetObjectType(oTarget);

effect eEffect;
eEffect = EffectVisualEffect(VFX_IMP_UNSUMMON);

if (nInt != OBJECT_TYPE_WAYPOINT)
   DelayCommand(25.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oTarget));
else
   DelayCommand(25.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eEffect, GetLocation(oTarget)));

oTarget = OBJECT_SELF;

DelayCommand(25.0, DestroyObject(oTarget, 3.0));

}
