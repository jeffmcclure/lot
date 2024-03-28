void main()
{

object oPC = GetPCItemLastEquippedBy();

object oItem;
oItem = GetPCItemLastEquipped();

if (!GetIsPC(oPC)) return;

AdjustAlignment(oPC, ALIGNMENT_EVIL, 100);

object oTarget;
oTarget = oPC;

//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead

int nInt;
nInt = GetObjectType(oTarget);

if (nInt != OBJECT_TYPE_WAYPOINT) ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DEATH), oTarget);
else ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DEATH), GetLocation(oTarget));

oTarget = oPC;

effect eEffect;
eEffect = EffectDeath();

ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oTarget);

eEffect = EffectDamage(1000, DAMAGE_TYPE_DIVINE, DAMAGE_POWER_NORMAL);

ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oPC);

oTarget = oPC;

//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead

nInt = GetObjectType(oTarget);

if (nInt != OBJECT_TYPE_WAYPOINT) ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DEATH), oTarget);
else ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DEATH), GetLocation(oTarget));

FloatingTextStringOnCreature("The cursed demon blade has corrupted your soul!", oPC);
SendMessageToPC(oPC, "You are no longer capable of completing your quest...");
FadeToBlack(oPC, FADE_SPEED_SLOW);
DelayCommand(3.0, EndGame(""));

}
