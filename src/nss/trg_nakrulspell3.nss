#include "inc_party"
#include "nw_i0_2q4luskan"
void main()
{

object oPC = GetLastUsedBy();
if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetPartyInt(oPC, "nakrulspell");

if (nInt == 2)
   {
   SetPartyInt(oPC, "nakrulspell", 3);
   FloatingTextStringOnCreature("Efficio Obitus Ut Inimicus", oPC);
   PlaySound("war_chant4");

object oTarget;
oTarget = GetObjectByTag("SND_NAKRULROAR");
SoundObjectStop(oTarget);

oTarget = GetObjectByTag("SPELL_FIRST");
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
oTarget = GetObjectByTag("SPELL_FIRST");
DelayCommand(3.0, DestroyObject(oTarget, 3.0));
oTarget = GetObjectByTag("SPELL_FIRST");
//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead
nInt = GetObjectType(oTarget);
eEffect = EffectVisualEffect(VFX_IMP_UNSUMMON);
if (nInt != OBJECT_TYPE_WAYPOINT)
   DelayCommand(3.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oTarget));
else
   DelayCommand(3.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eEffect, GetLocation(oTarget)));
oTarget = GetObjectByTag("SPELL_FIRST");
DelayCommand(3.0, DestroyObject(oTarget, 3.0));
oTarget = GetObjectByTag("SPELL_FIRST");
//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead
nInt = GetObjectType(oTarget);
eEffect = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);
if (nInt != OBJECT_TYPE_WAYPOINT)
   DelayCommand(3.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oTarget));
else
   DelayCommand(3.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eEffect, GetLocation(oTarget)));
oTarget = GetObjectByTag("SPELL_FIRST");
DelayCommand(3.0, DestroyObject(oTarget, 3.0));
oTarget = GetObjectByTag("PORTAL_SPELL1");
DelayCommand(3.0, DestroyObject(oTarget, 0.0));

oTarget = GetObjectByTag("SPELL_SECOND");
//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead
nInt = GetObjectType(oTarget);
eEffect = EffectVisualEffect(VFX_FNF_FIREBALL);
if (nInt != OBJECT_TYPE_WAYPOINT)
   DelayCommand(4.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oTarget));
else
   DelayCommand(4.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eEffect, GetLocation(oTarget)));
oTarget = GetObjectByTag("SPELL_SECOND");
DelayCommand(4.0, DestroyObject(oTarget, 3.0));
oTarget = GetObjectByTag("SPELL_SECOND");
//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead
nInt = GetObjectType(oTarget);
eEffect = EffectVisualEffect(VFX_IMP_UNSUMMON);
if (nInt != OBJECT_TYPE_WAYPOINT)
   DelayCommand(4.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oTarget));
else
   DelayCommand(4.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eEffect, GetLocation(oTarget)));
oTarget = GetObjectByTag("SPELL_SECOND");
DelayCommand(4.0, DestroyObject(oTarget, 3.0));
oTarget = GetObjectByTag("SPELL_SECOND");
//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead
nInt = GetObjectType(oTarget);
eEffect = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);
if (nInt != OBJECT_TYPE_WAYPOINT)
   DelayCommand(4.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oTarget));
else
   DelayCommand(4.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eEffect, GetLocation(oTarget)));
oTarget = GetObjectByTag("SPELL_SECOND");
DelayCommand(4.0, DestroyObject(oTarget, 3.0));
oTarget = GetObjectByTag("PORTAL_SPELL2");
DelayCommand(4.0, DestroyObject(oTarget, 0.0));

oTarget = GetObjectByTag("SPELL_THIRD");
//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead
nInt = GetObjectType(oTarget);
eEffect = EffectVisualEffect(VFX_FNF_FIREBALL);
if (nInt != OBJECT_TYPE_WAYPOINT)
   DelayCommand(5.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oTarget));
else
   DelayCommand(5.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eEffect, GetLocation(oTarget)));
oTarget = GetObjectByTag("SPELL_THIRD");
DelayCommand(5.0, DestroyObject(oTarget, 3.0));
oTarget = GetObjectByTag("SPELL_THIRD");
//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead
nInt = GetObjectType(oTarget);
eEffect = EffectVisualEffect(VFX_IMP_UNSUMMON);
if (nInt != OBJECT_TYPE_WAYPOINT)
   DelayCommand(5.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oTarget));
else
   DelayCommand(5.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eEffect, GetLocation(oTarget)));
oTarget = GetObjectByTag("SPELL_THIRD");
DelayCommand(5.0, DestroyObject(oTarget, 3.0));
oTarget = GetObjectByTag("SPELL_THIRD");
//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead
nInt = GetObjectType(oTarget);
eEffect = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);
if (nInt != OBJECT_TYPE_WAYPOINT)
   DelayCommand(5.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oTarget));
else
   DelayCommand(5.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eEffect, GetLocation(oTarget)));
oTarget = GetObjectByTag("SPELL_THIRD");
DelayCommand(5.0, DestroyObject(oTarget, 3.0));
oTarget = GetObjectByTag("PORTAL_SPELL3");
DelayCommand(5.0, DestroyObject(oTarget, 0.0));

oTarget = GetObjectByTag("DOOR_NAKRUL");
//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead
nInt = GetObjectType(oTarget);
eEffect = EffectVisualEffect(VFX_FNF_FIREBALL);
if (nInt != OBJECT_TYPE_WAYPOINT)
   DelayCommand(7.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oTarget));
else
   DelayCommand(7.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eEffect, GetLocation(oTarget)));
oTarget = GetObjectByTag("DOOR_NAKRUL");
DelayCommand(7.0, DestroyObject(oTarget, 3.0));
oTarget = GetObjectByTag("DOOR_NAKRUL");
//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead
nInt = GetObjectType(oTarget);
eEffect = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);
if (nInt != OBJECT_TYPE_WAYPOINT)
   DelayCommand(7.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oTarget));
else
   DelayCommand(7.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eEffect, GetLocation(oTarget)));
oTarget = GetObjectByTag("DOOR_NAKRUL");
DelayCommand(7.0, DestroyObject(oTarget, 3.0));
oTarget = GetObjectByTag("DOOR_NAKRUL");
//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead
nInt = GetObjectType(oTarget);
eEffect = EffectVisualEffect(VFX_IMP_DEATH);
if (nInt != OBJECT_TYPE_WAYPOINT)
   DelayCommand(7.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oTarget));
else
   DelayCommand(7.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eEffect, GetLocation(oTarget)));
oTarget = GetObjectByTag("DOOR_NAKRUL");
DelayCommand(7.0, DestroyObject(oTarget, 3.0));

location lTarget;
oTarget = GetWaypointByTag("WP_NAKRUL");
lTarget = GetLocation(oTarget);
DelayCommand(7.0, CreateObjectVoid(OBJECT_TYPE_CREATURE, "nakrul", lTarget));
eEffect = EffectVisualEffect(VFX_FNF_FIREBALL);
DelayCommand(7.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eEffect, lTarget));
   }
else if (GetPartyInt(oPC, "nakrulspell") == 3)
   {
   FloatingTextStringOnCreature("Efficio Obitus Ut Inimicus", oPC);
   PlaySound("war_chant4");
   }
else
   {
   SetPartyInt(oPC, "nakrulspell", 0);
   FloatingTextStringOnCreature("Efficio Obitus Ut Inimicus", oPC);
   PlaySound("war_chant4");
   }

}
