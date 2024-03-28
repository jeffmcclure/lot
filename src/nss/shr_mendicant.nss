#include "nw_i0_tool"
int nInt;
object oTarget;
void main()
{

object oPC = GetLastUsedBy();
if (!GetIsPC(oPC)) return;
int DoOnce = GetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF));
if (DoOnce==TRUE) return;
SetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF), TRUE);

if (GetGold(oPC) >= 2500)
   {
   oTarget = oPC;

//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead

   nInt = GetObjectType(oTarget);

   if (nInt != OBJECT_TYPE_WAYPOINT) ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_UNSUMMON), oTarget);
   else ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_UNSUMMON), GetLocation(oTarget));

   AssignCommand(oPC, TakeGoldFromCreature(2500, oPC, TRUE));
   RewardPartyXP(1000, oPC, TRUE);
   FloatingTextStringOnCreature("Give and you shall receive...", oPC);

   DelayCommand(8.0, ExecuteScript("rdm_shrine1a", OBJECT_SELF));
   oTarget = OBJECT_SELF;
   DelayCommand(10.0, DestroyObject(oTarget, 0.0));
   }
else
   {
   oTarget = oPC;

//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead

   nInt = GetObjectType(oTarget);

   if (nInt != OBJECT_TYPE_WAYPOINT) ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_UNSUMMON), oTarget);
   else ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_UNSUMMON), GetLocation(oTarget));

   nInt=GetGold(oPC);
   AssignCommand(oPC, TakeGoldFromCreature(nInt, oPC, TRUE));
   RewardPartyXP(1000, oPC, TRUE);
   FloatingTextStringOnCreature("Give and you shall receive...", oPC);

   DelayCommand(8.0, ExecuteScript("rdm_shrine1a", OBJECT_SELF));
   oTarget = OBJECT_SELF;
   DelayCommand(10.0, DestroyObject(oTarget, 0.0));

   }

}
