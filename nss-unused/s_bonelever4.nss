string sDeny;
void main()
{

object oPC = GetLastUsedBy();

if (!GetIsPC(oPC)) return;

if (GetItemPossessedBy(oPC, "D1_CALCIUMCRYSTAL")== OBJECT_INVALID)
   {
   sDeny="Your party must possess a white crystal to make this lever work.";

   SendMessageToPC(oPC, sDeny);

   return;
   }

SetLocalInt(oPC, "bonechamber", 5);

object oItem;
oItem = GetItemPossessedBy(oPC, "D1_CALCIUMCRYSTAL");

if (GetIsObjectValid(oItem))
   DestroyObject(oItem);

object oTarget;
//oTarget = GetObjectByTag("DOOR_BONE4");
//
//SetLocked(oTarget, FALSE);
//
//oTarget = GetObjectByTag("DOOR_BONE5");
//
//SetLocked(oTarget, FALSE);
//
oTarget = GetObjectByTag("DOOR_BONE2");

AssignCommand(oTarget, ActionCloseDoor(oTarget));

SetLocked(oTarget, TRUE);

oTarget = GetObjectByTag("DOOR_BONE3");

AssignCommand(oTarget, ActionCloseDoor(oTarget));

SetLocked(oTarget, TRUE);

SendMessageToPC(oPC, "Your hear doors opening, and you are suddenly transported somewhere...");

location lTarget;
oTarget = GetWaypointByTag("WP_BONETREASURE");

lTarget = GetLocation(oTarget);

//only do the jump if the location is valid.
//though not flawless, we just check if it is in a valid area.
//the script will stop if the location isn't valid - meaning that
//nothing put after the teleport will fire either.
//the current location won't be stored, either

if (GetAreaFromLocation(lTarget)==OBJECT_INVALID) return;

AssignCommand(oPC, ClearAllActions());

DelayCommand(2.0, AssignCommand(oPC, ActionJumpToLocation(lTarget)));

oTarget = oPC;

//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead

int nInt;
nInt = GetObjectType(oTarget);

if (nInt != OBJECT_TYPE_WAYPOINT) ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_UNSUMMON), oTarget);
else ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_UNSUMMON), GetLocation(oTarget));

}
