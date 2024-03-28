#include "inc_party"
effect eEffect;
object oTarget;
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

   eEffect = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);

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

   }
//nInt=GetPartyInt(oPC, "nakrulspell");

else if (GetPartyInt(oPC, "nakrulspell") == 3)
   {
   FloatingTextStringOnCreature("Efficio Obitus Ut Inimicus", oPC);

   }
else
   {
   SetPartyInt(oPC, "nakrulspell", 0);
    FloatingTextStringOnCreature("Efficio Obitus Ut Inimicus", oPC);

   }

}
