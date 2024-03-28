#include "inc_party"
void main()
{

object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetPartyInt(oPC, "kevintalk");
if (!(nInt == 0))
   return;

object oTarget;
oTarget = GetObjectByTag("GRD_KEVIN");
AssignCommand(oTarget, ActionStartConversation(oPC, ""));

}
