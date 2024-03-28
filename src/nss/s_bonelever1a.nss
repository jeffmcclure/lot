#include "inc_party"
void main()
{

object oPC = GetLastUsedBy();
if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetPartyInt(oPC, "bonelever1");
if (!(nInt == 0))
   return;

    if (GetPartyInt(OBJECT_SELF, "bPulled") == FALSE) {
        PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
        SetPartyInt(OBJECT_SELF, "bPulled", TRUE);
    }
    else {
        PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);
        SetPartyInt(OBJECT_SELF, "bPulled", FALSE);
    }

SetPartyInt(oPC, "bonelever1", 1);
object oTarget;
oTarget = GetObjectByTag("DOOR_BONE2");
SetLocked(oTarget, FALSE);
AssignCommand(oPC, ActionSpeakString("I hear something unlocking somewhere in this chamber..."));

}
