#include "inc_party"
void main()
{

object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;

int DoOnce = GetPartyInt(OBJECT_SELF, GetTag(OBJECT_SELF));
if (DoOnce==TRUE) return;
SetPartyInt(OBJECT_SELF, GetTag(OBJECT_SELF), TRUE);

object oTarget;
oTarget = GetObjectByTag("INVIS_LEORIC");

DelayCommand(2.0, AssignCommand(oTarget, ActionStartConversation(oPC, "con_leoric")));
//AssignCommand(oTarget, ActionStartConversation(oPC, "con_leoric"));

}

