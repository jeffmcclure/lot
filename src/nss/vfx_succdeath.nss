void main()
{

//object oPC = GetLastKiller();
//while (GetIsObjectValid(GetMaster(oPC)))
//   {
//   oPC=GetMaster(oPC);
//   }
//
//if (!GetIsPC(oPC)) return;

object oTarget;
oTarget = OBJECT_SELF;

//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead

int nInt;
nInt = GetObjectType(oTarget);

if (nInt != OBJECT_TYPE_WAYPOINT) ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_HOWL_ODD), oTarget);
else ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_HOWL_ODD), GetLocation(oTarget));

}

