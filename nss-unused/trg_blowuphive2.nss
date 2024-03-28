void main()
{

object oPC = GetPCSpeaker();
object oTarget;

oTarget = GetObjectByTag("HIVE_BOMB");
DestroyObject(oTarget, 0.0);

oTarget = GetObjectByTag("HIVE_XPLODE_01");
//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead
int nInt;
nInt = GetObjectType(oTarget);
effect eEffect;
eEffect = EffectVisualEffect(VFX_FNF_FIREBALL);
if (nInt != OBJECT_TYPE_WAYPOINT)
   DelayCommand(5.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oTarget));
else
   DelayCommand(5.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eEffect, GetLocation(oTarget)));
oTarget = GetObjectByTag("HIVE_XPLODE_01");
DelayCommand(5.0, DestroyObject(oTarget, 0.0));

oTarget = GetObjectByTag("HIVE_XPLODE_02");
//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead
nInt = GetObjectType(oTarget);
eEffect = EffectVisualEffect(VFX_FNF_FIREBALL);
if (nInt != OBJECT_TYPE_WAYPOINT)
   DelayCommand(6.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oTarget));
else
   DelayCommand(6.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eEffect, GetLocation(oTarget)));
oTarget = GetObjectByTag("HIVE_XPLODE_02");
DelayCommand(6.0, DestroyObject(oTarget, 0.0));

oTarget = GetObjectByTag("HIVE_XPLODE_03");
//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead
nInt = GetObjectType(oTarget);
eEffect = EffectVisualEffect(VFX_FNF_FIREBALL);
if (nInt != OBJECT_TYPE_WAYPOINT)
   DelayCommand(7.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oTarget));
else
   DelayCommand(7.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eEffect, GetLocation(oTarget)));
oTarget = GetObjectByTag("HIVE_XPLODE_03");
DelayCommand(7.0, DestroyObject(oTarget, 0.0));

oTarget = GetObjectByTag("HIVE_XPLODE_04");
//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead
nInt = GetObjectType(oTarget);
eEffect = EffectVisualEffect(VFX_FNF_FIREBALL);
if (nInt != OBJECT_TYPE_WAYPOINT)
   DelayCommand(8.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oTarget));
else
   DelayCommand(8.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eEffect, GetLocation(oTarget)));
oTarget = GetObjectByTag("HIVE_XPLODE_04");
DelayCommand(8.0, DestroyObject(oTarget, 0.0));

oTarget = GetObjectByTag("HIVE_XPLODE_05");
//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead
nInt = GetObjectType(oTarget);
eEffect = EffectVisualEffect(VFX_FNF_FIREBALL);
if (nInt != OBJECT_TYPE_WAYPOINT)
   DelayCommand(9.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oTarget));
else
   DelayCommand(9.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eEffect, GetLocation(oTarget)));
oTarget = GetObjectByTag("HIVE_XPLODE_05");
DelayCommand(9.0, DestroyObject(oTarget, 0.0));

oTarget = GetObjectByTag("HIVE_XPLODE_06");
//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead
nInt = GetObjectType(oTarget);
eEffect = EffectVisualEffect(VFX_FNF_FIREBALL);
if (nInt != OBJECT_TYPE_WAYPOINT)
   DelayCommand(10.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oTarget));
else
   DelayCommand(10.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eEffect, GetLocation(oTarget)));
oTarget = GetObjectByTag("HIVE_XPLODE_06");
DelayCommand(10.0, DestroyObject(oTarget, 0.0));

oTarget = GetObjectByTag("HIVE_XPLODE_07");
//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead
nInt = GetObjectType(oTarget);
eEffect = EffectVisualEffect(VFX_FNF_FIREBALL);
if (nInt != OBJECT_TYPE_WAYPOINT)
   DelayCommand(11.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oTarget));
else
   DelayCommand(11.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eEffect, GetLocation(oTarget)));
oTarget = GetObjectByTag("HIVE_XPLODE_07");
DelayCommand(11.0, DestroyObject(oTarget, 0.0));

oTarget = GetObjectByTag("HIVE_XPLODE_08");
//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead
nInt = GetObjectType(oTarget);
eEffect = EffectVisualEffect(VFX_FNF_FIREBALL);
if (nInt != OBJECT_TYPE_WAYPOINT)
   DelayCommand(12.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oTarget));
else
   DelayCommand(12.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eEffect, GetLocation(oTarget)));
oTarget = GetObjectByTag("HIVE_XPLODE_08");
DelayCommand(12.0, DestroyObject(oTarget, 0.0));

oTarget = GetObjectByTag("HIVE_XPLODE_09");
//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead
nInt = GetObjectType(oTarget);
eEffect = EffectVisualEffect(VFX_FNF_FIREBALL);
if (nInt != OBJECT_TYPE_WAYPOINT)
   DelayCommand(13.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oTarget));
else
   DelayCommand(13.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eEffect, GetLocation(oTarget)));
oTarget = GetObjectByTag("HIVE_XPLODE_09");
DelayCommand(13.0, DestroyObject(oTarget, 0.0));

oTarget = GetObjectByTag("HIVE_XPLODE_10");
//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead
nInt = GetObjectType(oTarget);
eEffect = EffectVisualEffect(VFX_FNF_FIREBALL);
if (nInt != OBJECT_TYPE_WAYPOINT)
   DelayCommand(14.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oTarget));
else
   DelayCommand(14.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eEffect, GetLocation(oTarget)));
oTarget = GetObjectByTag("HIVE_XPLODE_10");
DelayCommand(14.0, DestroyObject(oTarget, 0.0));

oTarget = GetObjectByTag("HIVE_XPLODE_11");
//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead
nInt = GetObjectType(oTarget);
eEffect = EffectVisualEffect(VFX_FNF_FIREBALL);
if (nInt != OBJECT_TYPE_WAYPOINT)
   DelayCommand(15.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oTarget));
else
   DelayCommand(15.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eEffect, GetLocation(oTarget)));
oTarget = GetObjectByTag("HIVE_XPLODE_11");
DelayCommand(15.0, DestroyObject(oTarget, 0.0));

oTarget = GetObjectByTag("HIVE_XPLODE_12");
//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead
nInt = GetObjectType(oTarget);
eEffect = EffectVisualEffect(VFX_FNF_FIREBALL);
if (nInt != OBJECT_TYPE_WAYPOINT)
   DelayCommand(16.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oTarget));
else
   DelayCommand(16.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eEffect, GetLocation(oTarget)));
oTarget = GetObjectByTag("HIVE_XPLODE_12");
DelayCommand(16.0, DestroyObject(oTarget, 0.0));

oTarget = GetObjectByTag("HIVE_XPLODE_13");
//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead
nInt = GetObjectType(oTarget);
eEffect = EffectVisualEffect(VFX_FNF_FIREBALL);
if (nInt != OBJECT_TYPE_WAYPOINT)
   DelayCommand(17.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oTarget));
else
   DelayCommand(17.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eEffect, GetLocation(oTarget)));
oTarget = GetObjectByTag("HIVE_XPLODE_13");
DelayCommand(17.0, DestroyObject(oTarget, 0.0));

oTarget = GetObjectByTag("HIVE_XPLODE_14");
//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead
nInt = GetObjectType(oTarget);
eEffect = EffectVisualEffect(VFX_FNF_FIREBALL);
if (nInt != OBJECT_TYPE_WAYPOINT)
   DelayCommand(18.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oTarget));
else
   DelayCommand(18.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eEffect, GetLocation(oTarget)));
oTarget = GetObjectByTag("HIVE_XPLODE_14");
DelayCommand(18.0, DestroyObject(oTarget, 0.0));

oTarget = GetObjectByTag("HIVE_XPLODE_15");
//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead
nInt = GetObjectType(oTarget);
eEffect = EffectVisualEffect(VFX_FNF_FIREBALL);
if (nInt != OBJECT_TYPE_WAYPOINT)
   DelayCommand(19.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oTarget));
else
   DelayCommand(19.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eEffect, GetLocation(oTarget)));
oTarget = GetObjectByTag("HIVE_XPLODE_15");
DelayCommand(19.0, DestroyObject(oTarget, 0.0));

oTarget = GetObjectByTag("HIVE_XPLODE_16");
//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead
nInt = GetObjectType(oTarget);
eEffect = EffectVisualEffect(VFX_FNF_FIREBALL);
if (nInt != OBJECT_TYPE_WAYPOINT)
   DelayCommand(20.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oTarget));
else
   DelayCommand(20.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eEffect, GetLocation(oTarget)));
oTarget = GetObjectByTag("HIVE_XPLODE_16");
DelayCommand(20.0, DestroyObject(oTarget, 0.0));

}
