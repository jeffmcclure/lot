void main()
{

object oPC = GetLastKiller();

while (GetIsObjectValid(GetMaster(oPC)))
   {
   oPC=GetMaster(oPC);
   }

if (!GetIsPC(oPC)) return;

object oTarget;
object oSpawn;
location lTarget;
oTarget = GetWaypointByTag("WP_ANDARIELEXIT");

lTarget = GetLocation(oTarget);

oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "tristramexit", lTarget);

oTarget = oSpawn;

//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead

int nInt;
nInt = GetObjectType(oTarget);

if (nInt != OBJECT_TYPE_WAYPOINT) DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_GATE), oTarget));
else DelayCommand(0.5, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_GATE), GetLocation(oTarget)));

oTarget = GetObjectByTag("PORTAL_TRISTRAM2");

//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead

nInt = GetObjectType(oTarget);

effect eEffect;
eEffect = EffectVisualEffect(VFX_IMP_UNSUMMON);

if (nInt != OBJECT_TYPE_WAYPOINT)
   DelayCommand(600.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oTarget));
else
   DelayCommand(600.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eEffect, GetLocation(oTarget)));

oTarget = GetObjectByTag("PORTAL_TRISTRAM2");

DelayCommand(600.0, DestroyObject(oTarget, 3.0));

}
