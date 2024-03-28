void main()
{

object oPC = GetPCSpeaker();

object oTarget;
oTarget = OBJECT_SELF;

//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead

int nInt;
nInt = GetObjectType(oTarget);

if (nInt != OBJECT_TYPE_WAYPOINT) ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_CELESTIAL), oTarget);
else ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_CELESTIAL), GetLocation(oTarget));

oTarget = OBJECT_SELF;

//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead

nInt = GetObjectType(oTarget);

effect eEffect;
eEffect = EffectVisualEffect(VFX_IMP_DEATH);

if (nInt != OBJECT_TYPE_WAYPOINT)
   DelayCommand(2.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oTarget));
else
   DelayCommand(2.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eEffect, GetLocation(oTarget)));

oTarget = OBJECT_SELF;

DelayCommand(2.0, DestroyObject(oTarget, 3.0));

AssignCommand(GetObjectByTag("LACHDANAN"), ActionSpeakString("Goodbye..."));
AdjustAlignment(oPC, ALIGNMENT_GOOD, 5);

}
