#include "inc_party"
string sDeny;
void main()
{

object oPC = GetLastUsedBy();
if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetPartyInt(oPC, "quadrant2");
if (!(nInt == 0))
   return;

    if (GetPartyInt(OBJECT_SELF, "xPulled2") == FALSE) {
        PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
        SetPartyInt(OBJECT_SELF, "xPulled2", TRUE);
    }
    else {
        PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);
        SetPartyInt(OBJECT_SELF, "xPulled2", FALSE);
    }

SetPartyInt(oPC, "quadrant2", 1);
object oTarget;
oTarget = GetObjectByTag("DOOR_QUADRANT3A");
SetLocked(oTarget, FALSE);
AssignCommand(oTarget, ActionOpenDoor(oTarget));

oTarget = GetObjectByTag("DOOR_QUADRANT3B");
SetLocked(oTarget, FALSE);
AssignCommand(oTarget, ActionOpenDoor(oTarget));

oTarget = GetObjectByTag("DOOR_QUADRANT3C");
SetLocked(oTarget, FALSE);
AssignCommand(oTarget, ActionOpenDoor(oTarget));

oTarget = GetObjectByTag("DOOR_QUADRANT3D");
SetLocked(oTarget, FALSE);
AssignCommand(oTarget, ActionOpenDoor(oTarget));

FloatingTextStringOnCreature("The third quadrant has been unlocked...", oPC);
//AssignCommand(oPC, ActionSpeakString("I hear doors opening somewhere in this area!"));

}
