#include "inc_party"
string sDeny;
void main()
{

object oPC = GetLastUsedBy();
if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetPartyInt(oPC, "diablokill");
if (!(nInt == 1))
   {
   sDeny="The lever won't budge. I might need to pull another lever before this one...";
   SendMessageToPC(oPC, sDeny);
   return;
   }

nInt=GetPartyInt(oPC, "quadrant3b");
if (!(nInt == 0))
   return;

    if (GetPartyInt(OBJECT_SELF, "xPulled4") == FALSE) {
        PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
        SetPartyInt(OBJECT_SELF, "xPulled4", TRUE);
    }
    else {
        PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);
        SetPartyInt(OBJECT_SELF, "xPulled4", FALSE);
    }

SetPartyInt(oPC, "quadrant3b", 1);
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

FloatingTextStringOnCreature("The fourth quadrant has been unlocked...", oPC);
AssignCommand(oPC, ActionSpeakString("It is time to face this vile demon!"));

}
