//#include "nw_i0_generic"
#include "inc_party"
string sDeny;
void main()
{

object oPC = GetLastUsedBy();
if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetPartyInt(oPC, "quadrant3a");
if (!(nInt == 0))
   return;

    if (GetPartyInt(OBJECT_SELF, "xPulled3") == FALSE) {
        PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
        SetPartyInt(OBJECT_SELF, "xPulled3", TRUE);
    }
    else {
        PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);
        SetPartyInt(OBJECT_SELF, "xPulled3", FALSE);
    }

SetPartyInt(oPC, "quadrant3a", 1);
SetPartyInt(oPC, "diablokill", 1);

object oTarget;
object oSpawn;
location lTarget;

oTarget = GetObjectByTag("TREE_HELL");

//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead

nInt = GetObjectType(oTarget);

if (nInt != OBJECT_TYPE_WAYPOINT) ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_FIREBALL), oTarget);
else ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_FIREBALL), GetLocation(oTarget));

oTarget = GetObjectByTag("TREE_HELL4");
DestroyObject(oTarget, 3.0);

oTarget = GetWaypointByTag("WP_HELL4TRIST");
lTarget = GetLocation(oTarget);
oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "hell4portal", lTarget);

oTarget = oSpawn;

//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead

nInt = GetObjectType(oTarget);

if (nInt != OBJECT_TYPE_WAYPOINT) DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_GATE), oTarget));
else DelayCommand(0.5, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_GATE), GetLocation(oTarget)));

oTarget = GetWaypointByTag("WP_TRISTRAMHELL4");
lTarget = GetLocation(oTarget);
oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "tristhell4", lTarget);

oTarget = oSpawn;

//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead

nInt = GetObjectType(oTarget);

if (nInt != OBJECT_TYPE_WAYPOINT) DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_GATE), oTarget));
else DelayCommand(0.5, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_GATE), GetLocation(oTarget)));

AssignCommand(oPC, ActionSpeakString("Nothing seems to happen. I might need to pull another lever!"));

}
