#include "nw_i0_tool"
void main()
{
object oPC = GetLastDisturbed();
if (!GetIsPC(oPC)) return;

    object oItem = GetInventoryDisturbItem();
    int nItemBase =  GetBaseItemType(oItem);
    if(GetLocalInt(OBJECT_SELF,"") == FALSE &&
       GetTag(oItem) == "TRINITY_TOTEM3" )
    {
        DestroyObject(oItem);

object oTarget;
oTarget = GetObjectByTag("WP_TRINITY_01");

//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead

int nInt;
nInt = GetObjectType(oTarget);

effect eEffect;
eEffect = EffectVisualEffect(VFX_IMP_DIVINE_STRIKE_FIRE);

if (nInt != OBJECT_TYPE_WAYPOINT)
   DelayCommand(5.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oTarget));
else
   DelayCommand(5.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eEffect, GetLocation(oTarget)));

oTarget = GetObjectByTag("WP_TRINITY_01");

//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead

nInt = GetObjectType(oTarget);

eEffect = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);

if (nInt != OBJECT_TYPE_WAYPOINT)
   DelayCommand(5.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oTarget));
else
   DelayCommand(5.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eEffect, GetLocation(oTarget)));

oTarget = GetObjectByTag("WP_TRINITY_02");

//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead

nInt = GetObjectType(oTarget);

eEffect = EffectVisualEffect(VFX_IMP_DIVINE_STRIKE_FIRE);

if (nInt != OBJECT_TYPE_WAYPOINT)
   DelayCommand(6.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oTarget));
else
   DelayCommand(6.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eEffect, GetLocation(oTarget)));

oTarget = GetObjectByTag("WP_TRINITY_02");

//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead

nInt = GetObjectType(oTarget);

eEffect = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);

if (nInt != OBJECT_TYPE_WAYPOINT)
   DelayCommand(6.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oTarget));
else
   DelayCommand(6.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eEffect, GetLocation(oTarget)));

oTarget = GetObjectByTag("WP_TRINITY_03");

//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead

nInt = GetObjectType(oTarget);

eEffect = EffectVisualEffect(VFX_IMP_DIVINE_STRIKE_FIRE);

if (nInt != OBJECT_TYPE_WAYPOINT)
   DelayCommand(7.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oTarget));
else
   DelayCommand(7.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eEffect, GetLocation(oTarget)));

oTarget = GetObjectByTag("WP_TRINITY_03");

//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead

nInt = GetObjectType(oTarget);

eEffect = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);

if (nInt != OBJECT_TYPE_WAYPOINT)
   DelayCommand(7.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oTarget));
else
   DelayCommand(7.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eEffect, GetLocation(oTarget)));

oTarget = GetObjectByTag("TRINITYROCK_01");

//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead

nInt = GetObjectType(oTarget);

eEffect = EffectVisualEffect(VFX_FNF_FIREBALL);

if (nInt != OBJECT_TYPE_WAYPOINT)
   DelayCommand(8.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oTarget));
else
   DelayCommand(8.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eEffect, GetLocation(oTarget)));

oTarget = GetObjectByTag("TRINITYROCK_01");

DelayCommand(8.0, DestroyObject(oTarget, 3.0));

oTarget = GetObjectByTag("TRINITYROCK_02");

//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead

nInt = GetObjectType(oTarget);

eEffect = EffectVisualEffect(VFX_FNF_FIREBALL);

if (nInt != OBJECT_TYPE_WAYPOINT)
   DelayCommand(8.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oTarget));
else
   DelayCommand(8.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eEffect, GetLocation(oTarget)));

oTarget = GetObjectByTag("TRINITYROCK_02");

DelayCommand(8.0, DestroyObject(oTarget, 3.0));

oTarget = GetObjectByTag("TRINITYROCK_03");

//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead

nInt = GetObjectType(oTarget);

eEffect = EffectVisualEffect(VFX_FNF_FIREBALL);

if (nInt != OBJECT_TYPE_WAYPOINT)
   DelayCommand(8.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oTarget));
else
   DelayCommand(8.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eEffect, GetLocation(oTarget)));

oTarget = GetObjectByTag("TRINITYROCK_03");

DelayCommand(8.0, DestroyObject(oTarget, 3.0));

oTarget = GetObjectByTag("TRINITYROCK_04");

//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead

nInt = GetObjectType(oTarget);

eEffect = EffectVisualEffect(VFX_FNF_FIREBALL);

if (nInt != OBJECT_TYPE_WAYPOINT)
   DelayCommand(8.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oTarget));
else
   DelayCommand(8.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eEffect, GetLocation(oTarget)));

oTarget = GetObjectByTag("TRINITYROCK_04");

DelayCommand(8.0, DestroyObject(oTarget, 3.0));

oTarget = GetObjectByTag("TRINITYROCK_05");

//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead

nInt = GetObjectType(oTarget);

eEffect = EffectVisualEffect(VFX_FNF_FIREBALL);

if (nInt != OBJECT_TYPE_WAYPOINT)
   DelayCommand(8.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oTarget));
else
   DelayCommand(8.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eEffect, GetLocation(oTarget)));

oTarget = GetObjectByTag("TRINITYROCK_05");

DelayCommand(8.0, DestroyObject(oTarget, 3.0));

oTarget = GetObjectByTag("WP_TRINITY_04");

//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead

nInt = GetObjectType(oTarget);

eEffect = EffectVisualEffect(VFX_FNF_SUNBEAM);

if (nInt != OBJECT_TYPE_WAYPOINT)
   DelayCommand(8.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oTarget));
else
   DelayCommand(8.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eEffect, GetLocation(oTarget)));

oTarget = GetObjectByTag("WP_TRINITY_04");

//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead

nInt = GetObjectType(oTarget);

eEffect = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);

if (nInt != OBJECT_TYPE_WAYPOINT)
   DelayCommand(8.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oTarget));
else
   DelayCommand(8.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eEffect, GetLocation(oTarget)));
  }
}

