string sDeny;
void main()
{

object oPC = GetLastUsedBy();

if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetLocalInt(oPC, "andariel");

if (!(nInt <= 4))
   {
   sDeny="You cannot use this portal after killing Andariel...";

   SendMessageToPC(oPC, sDeny);

   return;
   }

if (GetItemPossessedBy(oPC, "ITM_SANCTUARY")!= OBJECT_INVALID)
   return;

SendMessageToPC(oPC, "You have been transported to temporary serenity from the anguish below...");

object oTarget;
location lTarget;
oTarget = GetWaypointByTag("WP_SERENITY");

lTarget = GetLocation(oTarget);

//only do the jump if the location is valid.
//though not flawless, we just check if it is in a valid area.
//the script will stop if the location isn't valid - meaning that
//nothing put after the teleport will fire either.
//the current location won't be stored, either

if (GetAreaFromLocation(lTarget)==OBJECT_INVALID) return;

AssignCommand(oPC, ClearAllActions());

DelayCommand(3.0, AssignCommand(oPC, ActionJumpToLocation(lTarget)));

oTarget = oPC;

//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead

nInt = GetObjectType(oTarget);

if (nInt != OBJECT_TYPE_WAYPOINT) ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_UNSUMMON), oTarget);
else ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_UNSUMMON), GetLocation(oTarget));

}
