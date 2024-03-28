#include "inc_party"
void main()
{

object oPC = GetLastPerceived();
if (!GetIsPC(oPC)) return;

if (!GetLastPerceptionSeen()) return;
int nInt;
nInt=GetPartyInt(oPC, "cowmantalk");

if (!(nInt == 0))
   return;

object oTarget;
oTarget = OBJECT_SELF;

AssignCommand(oTarget, ActionStartConversation(oPC, ""));
SetPartyInt(oPC, "cowmantalk", 1);

}
