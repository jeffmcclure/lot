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

oTarget = oPC;
effect eEffect;
eEffect = EffectACIncrease(3);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 900.0f);

oTarget = oPC;
eEffect = EffectAbilityIncrease(ABILITY_CONSTITUTION, 1);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 900.0f);

oTarget = oPC;
eEffect = EffectSpellResistanceIncrease(10);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 900.0f);

FloatingTextStringOnCreature("While the spirit is vigilant, the body thrives...", oPC);

DelayCommand(8.0, ExecuteScript("rdm_shrine1d", OBJECT_SELF));
oTarget = OBJECT_SELF;
DelayCommand(10.0, DestroyObject(oTarget, 0.0));

}

