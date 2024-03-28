string sDeny;
void main()
{

object oPC = GetLastUsedBy();

if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetLocalInt(oPC, "diablokill");

if (!(nInt == 4))
   {
   sDeny="The lever won't budge. You might need to pull another lever before this one...";

   SendMessageToPC(oPC, sDeny);

   return;
   }

object oTarget;
oTarget = GetObjectByTag("DOOR_QUADRANT4A");

SetLocked(oTarget, FALSE);

AssignCommand(oTarget, ActionOpenDoor(oTarget));

oTarget = GetObjectByTag("DOOR_QUADRANT4B");

SetLocked(oTarget, FALSE);

AssignCommand(oTarget, ActionOpenDoor(oTarget));

oTarget = GetObjectByTag("DOOR_QUADRANT4C");

SetLocked(oTarget, FALSE);

AssignCommand(oTarget, ActionOpenDoor(oTarget));

oTarget = GetObjectByTag("DOOR_QUADRANT4D");

SetLocked(oTarget, FALSE);

AssignCommand(oTarget, ActionOpenDoor(oTarget));

oTarget = GetObjectByTag("DOOR_QUADRANT2C");

AssignCommand(oTarget, ActionCloseDoor(oTarget));

SetLocked(oTarget, TRUE);

oTarget = oPC;

//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead

nInt = GetObjectType(oTarget);

if (nInt != OBJECT_TYPE_WAYPOINT) ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SCREEN_SHAKE), oTarget);
else ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SCREEN_SHAKE), GetLocation(oTarget));

SendMessageToPC(oPC, "You hear a terrifying roar in the distance... Diablo is here!");

}
