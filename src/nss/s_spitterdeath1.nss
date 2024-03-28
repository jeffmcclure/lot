void main()
{

object oPC = GetLastKiller();

while (GetIsObjectValid(GetMaster(oPC)))
   {
   oPC=GetMaster(oPC);
   }

if (!GetIsPC(oPC)) return;

effect eEffect;
eEffect = EffectDamage(10, DAMAGE_TYPE_ACID, DAMAGE_POWER_NORMAL);

ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oPC);

object oTarget;
oTarget = OBJECT_SELF;

//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead

int nInt;
nInt = GetObjectType(oTarget);

if (nInt != OBJECT_TYPE_WAYPOINT) ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_ACID_L), oTarget);
else ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_ACID_L), GetLocation(oTarget));

ExecuteScript("trg_demonbrain", OBJECT_SELF);

}
