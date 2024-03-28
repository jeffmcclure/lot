#include "inc_party"
void main()
{

object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;

int DoOnce = GetPartyInt(OBJECT_SELF, GetTag(OBJECT_SELF));
if (DoOnce==TRUE) return;
SetPartyInt(OBJECT_SELF, GetTag(OBJECT_SELF), TRUE);

object oTarget;
oTarget = GetObjectByTag("INVIS_WARLORD");

AssignCommand(oTarget, ActionStartConversation(oPC, "con_warlordx"));

//SendMessageToPC(oPC, "My blade sings for your blood, mortal... and by my dark masters it shall not be denied!");

}

