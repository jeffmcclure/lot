void main()
{

object oPC = GetPCSpeaker();
object oTarget;

SetLocalInt(oPC, "cowbomb", 1);

oTarget = GetObjectByTag("HIVE_BOMB");
DestroyObject(oTarget, 0.0);

oTarget = GetObjectByTag("PT_XPLODE_01");

//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead

int nInt;
nInt = GetObjectType(oTarget);

effect eEffect;
eEffect = EffectVisualEffect(VFX_FNF_FIREBALL);

if (nInt != OBJECT_TYPE_WAYPOINT)
   DelayCommand(3.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oTarget));
else
   DelayCommand(3.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eEffect, GetLocation(oTarget)));

oTarget = GetObjectByTag("PT_XPLODE_02");

//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead

nInt = GetObjectType(oTarget);

eEffect = EffectVisualEffect(VFX_FNF_FIREBALL);

if (nInt != OBJECT_TYPE_WAYPOINT)
   DelayCommand(4.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oTarget));
else
   DelayCommand(4.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eEffect, GetLocation(oTarget)));

oTarget = GetObjectByTag("PT_XPLODE_03");

//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead

nInt = GetObjectType(oTarget);

eEffect = EffectVisualEffect(VFX_FNF_FIREBALL);

if (nInt != OBJECT_TYPE_WAYPOINT)
   DelayCommand(5.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oTarget));
else
   DelayCommand(5.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eEffect, GetLocation(oTarget)));

oTarget = GetObjectByTag("PT_XPLODE_04");

//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead

nInt = GetObjectType(oTarget);

eEffect = EffectVisualEffect(VFX_FNF_FIREBALL);

if (nInt != OBJECT_TYPE_WAYPOINT)
   DelayCommand(6.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oTarget));
else
   DelayCommand(6.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eEffect, GetLocation(oTarget)));

oTarget = GetObjectByTag("PT_XPLODE_01");

//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead

nInt = GetObjectType(oTarget);

eEffect = EffectVisualEffect(VFX_FNF_HORRID_WILTING);

if (nInt != OBJECT_TYPE_WAYPOINT)
   DelayCommand(6.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oTarget));
else
   DelayCommand(6.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eEffect, GetLocation(oTarget)));

oTarget = GetObjectByTag("HIVE_XPLODE_01");
DelayCommand(4.0, DestroyObject(oTarget, 0.0));

oTarget = GetObjectByTag("HIVE_XPLODE_02");
DelayCommand(4.0, DestroyObject(oTarget, 0.0));

oTarget = GetObjectByTag("HIVE_XPLODE_03");
DelayCommand(4.0, DestroyObject(oTarget, 0.0));

oTarget = GetObjectByTag("HIVE_XPLODE_04");
DelayCommand(4.0, DestroyObject(oTarget, 0.0));

oTarget = GetObjectByTag("HIVE_XPLODE_05");
DelayCommand(4.0, DestroyObject(oTarget, 0.0));

oTarget = GetObjectByTag("HIVE_XPLODE_06");
DelayCommand(5.0, DestroyObject(oTarget, 0.0));

oTarget = GetObjectByTag("HIVE_XPLODE_07");
DelayCommand(5.0, DestroyObject(oTarget, 0.0));

oTarget = GetObjectByTag("HIVE_XPLODE_08");
DelayCommand(5.0, DestroyObject(oTarget, 0.0));

oTarget = GetObjectByTag("HIVE_XPLODE_09");
DelayCommand(5.0, DestroyObject(oTarget, 0.0));

oTarget = GetObjectByTag("HIVE_XPLODE_10");
DelayCommand(5.0, DestroyObject(oTarget, 0.0));

oTarget = GetObjectByTag("HIVE_XPLODE_11");
DelayCommand(6.0, DestroyObject(oTarget, 0.0));

oTarget = GetObjectByTag("HIVE_XPLODE_12");
DelayCommand(6.0, DestroyObject(oTarget, 0.0));

oTarget = GetObjectByTag("HIVE_XPLODE_13");
DelayCommand(6.0, DestroyObject(oTarget, 0.0));

oTarget = GetObjectByTag("HIVE_XPLODE_14");
DelayCommand(6.0, DestroyObject(oTarget, 0.0));

oTarget = GetObjectByTag("HIVE_XPLODE_15");
DelayCommand(6.0, DestroyObject(oTarget, 0.0));

oTarget = GetObjectByTag("HIVE_XPLODE_16");
DelayCommand(6.0, DestroyObject(oTarget, 0.0));

}
