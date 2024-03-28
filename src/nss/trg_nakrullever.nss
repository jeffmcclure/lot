#include "inc_party"
#include "nw_i0_2q4luskan"
void main()
{

object oPC = GetLastUsedBy();
if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetPartyInt(oPC, "nakrulspell");
if (!(nInt <= 2))
   return;

nInt=GetPartyInt(oPC, "levernakrul");
if (!(nInt == 0))
   return;

    if (GetPartyInt(OBJECT_SELF, "zPulled") == FALSE) {
        PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
        SetPartyInt(OBJECT_SELF, "zPulled", TRUE);
    }
    else {
        PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);
        SetPartyInt(OBJECT_SELF, "zPulled", FALSE);
    }

SetPartyInt(oPC, "levernakrul", 1);

object oTarget;
oTarget = GetObjectByTag("DOOR_NAKRUL");
SetLocked(oTarget, FALSE);
AssignCommand(oTarget, ActionOpenDoor(oTarget));

oTarget = GetObjectByTag("SND_NAKRULROAR");
SoundObjectStop(oTarget);

location lTarget;
oTarget = GetWaypointByTag("WP_NAKRUL");
lTarget = GetLocation(oTarget);
DelayCommand(5.0, CreateObjectVoid(OBJECT_TYPE_CREATURE, "nakrulstrong", lTarget));
effect eEffect;
eEffect = EffectVisualEffect(VFX_FNF_FIREBALL);
DelayCommand(5.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eEffect, lTarget));
SetPartyInt(oPC, "nakrulspell", 3);

oTarget = GetObjectByTag("SPELL_FIRST");
//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead
nInt = GetObjectType(oTarget);
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

}

