object oTarget;
effect eEffect;
void main()
{

object oPC = GetLastUsedBy();

if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetLocalInt(oPC, "hellforge");

if (nInt == 5)
   {
   eEffect = EffectDamage(50, DAMAGE_TYPE_FIRE, DAMAGE_POWER_NORMAL);

   ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oPC);

   oTarget = oPC;

//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead

   nInt = GetObjectType(oTarget);

   if (nInt != OBJECT_TYPE_WAYPOINT) ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_FIREBALL), oTarget);
   else ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_FIREBALL), GetLocation(oTarget));

   //SendMessageToPC(oPC, "You have already used this.  Time to move on.");
   ExecuteScript("s_onusedconverse", OBJECT_SELF);
   }
}
