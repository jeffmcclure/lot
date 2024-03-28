string sDeny;
void main()
{

object oPC = GetLastOpenedBy();

if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetLocalInt(oPC, "hellforge");

if (!(nInt <= 4))
   {
   sDeny="You no longer have any use for the hellforge";

   SendMessageToPC(oPC, sDeny);

   return;
   }

effect eEffect;
eEffect = EffectDamage(50, DAMAGE_TYPE_FIRE, DAMAGE_POWER_NORMAL);

ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oPC);

object oTarget;
oTarget = oPC;

//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead

nInt = GetObjectType(oTarget);

if (nInt != OBJECT_TYPE_WAYPOINT) ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_FIREBALL), oTarget);
else ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_FIREBALL), GetLocation(oTarget));

oTarget = OBJECT_SELF;

SetLocked(oTarget, FALSE);

ExecuteScript("loot_unique", OBJECT_SELF);

oTarget = OBJECT_SELF;

DelayCommand(10.0, SetLocked(oTarget, TRUE));

}
