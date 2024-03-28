#include "inc_party"
//#include "pqj_inc"
void main()
{

object oPC = GetLastKiller();
while (GetIsObjectValid(GetMaster(oPC)))
   {
   oPC=GetMaster(oPC);
   }

if (!GetIsPC(oPC)) return;

SetPartyInt(oPC, "diabloquest", 5);
SetPartyInt(oPC, "diablokill", 5);

//AddPersistentJournalQuestEntry("QST_DIABLO", 2, oPC, TRUE, FALSE);

object oTarget;
oTarget = oPC;

//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead

int nInt;
nInt = GetObjectType(oTarget);

if (nInt != OBJECT_TYPE_WAYPOINT) ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SCREEN_SHAKE), oTarget);
else ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SCREEN_SHAKE), GetLocation(oTarget));

oTarget = OBJECT_SELF;

//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead

nInt = GetObjectType(oTarget);

if (nInt != OBJECT_TYPE_WAYPOINT) ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SCREEN_SHAKE), oTarget);
else ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SCREEN_SHAKE), GetLocation(oTarget));

object oSpawn;
location lTarget;
oTarget = GetWaypointByTag("WP_TRISTRAM");

lTarget = GetLocation(oTarget);

oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "tristramport", lTarget);

oTarget = oSpawn;

//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead

nInt = GetObjectType(oTarget);

if (nInt != OBJECT_TYPE_WAYPOINT) DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_GATE), oTarget));
else DelayCommand(0.5, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_GATE), GetLocation(oTarget)));

oTarget = GetObjectByTag("PORTAL_TRISTRAM");

//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead

nInt = GetObjectType(oTarget);

effect eEffect;
eEffect = EffectVisualEffect(VFX_IMP_UNSUMMON);

if (nInt != OBJECT_TYPE_WAYPOINT)
   DelayCommand(600.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oTarget));
else
   DelayCommand(600.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eEffect, GetLocation(oTarget)));

oTarget = GetObjectByTag("PORTAL_TRISTRAM");

DelayCommand(600.0, DestroyObject(oTarget, 3.0));

}
