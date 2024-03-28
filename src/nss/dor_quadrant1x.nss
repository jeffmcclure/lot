#include "inc_party"
string sDeny;
void main()
{

object oPC = GetLastUsedBy();
if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetPartyInt(oPC, "quadrant1");
if (!(nInt == 0))
   return;

    if (GetPartyInt(OBJECT_SELF, "xPulled1") == FALSE) {
        PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
        SetPartyInt(OBJECT_SELF, "xPulled1", TRUE);
    }
    else {
        PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);
        SetPartyInt(OBJECT_SELF, "xPulled1", FALSE);
    }

SetPartyInt(oPC, "quadrant1", 1);
object oTarget;
oTarget = GetObjectByTag("DOOR_QUADRANT2A");
SetLocked(oTarget, FALSE);
AssignCommand(oTarget, ActionOpenDoor(oTarget));

oTarget = GetObjectByTag("DOOR_QUADRANT2B");
SetLocked(oTarget, FALSE);
AssignCommand(oTarget, ActionOpenDoor(oTarget));

oTarget = GetObjectByTag("DOOR_QUADRANT2C");
SetLocked(oTarget, FALSE);
AssignCommand(oTarget, ActionOpenDoor(oTarget));

FloatingTextStringOnCreature("The second quadrant has been unlocked...", oPC);
//AssignCommand(oPC, ActionSpeakString("I hear doors opening somewhere in this area!"));

}
