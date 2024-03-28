void main()
{

object oPC = GetFirstPC();

object oTarget;
object oSpawn;
location lTarget;

oTarget = GetWaypointByTag("WP_ANDARIELEXIT");
lTarget = GetLocation(oTarget);
oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "crsdfrstexit", lTarget);

oTarget = oSpawn;

//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead

int nInt;
nInt = GetObjectType(oTarget);

if (nInt != OBJECT_TYPE_WAYPOINT) DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_GATE), oTarget));
else DelayCommand(0.5, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_GATE), GetLocation(oTarget)));

oTarget = GetWaypointByTag("WP_CURSEDFORESTX");
lTarget = GetLocation(oTarget);
oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "andarielportx", lTarget);

oTarget = oSpawn;

//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead

nInt = GetObjectType(oTarget);

if (nInt != OBJECT_TYPE_WAYPOINT) DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_GATE), oTarget));
else DelayCommand(0.5, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_GATE), GetLocation(oTarget)));

}

