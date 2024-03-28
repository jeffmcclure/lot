#include "inc_party"
void main()
{

object oPC = GetLastUsedBy();
if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetPartyInt(oPC, "bonelever2");
if (!(nInt == 0))
   return;

    if (GetPartyInt(OBJECT_SELF, "bPulled2") == FALSE) {
        PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
        SetPartyInt(OBJECT_SELF, "bPulled2", TRUE);
    }
    else {
        PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);
        SetPartyInt(OBJECT_SELF, "bPulled2", FALSE);
    }

SetPartyInt(oPC, "bonelever2", 1);
object oTarget;
oTarget = GetObjectByTag("DOOR_BONE3");
SetLocked(oTarget, FALSE);
AssignCommand(oPC, ActionSpeakString("I hear something unlocking somewhere in this chamber..."));

}
