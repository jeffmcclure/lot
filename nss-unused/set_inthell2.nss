#include "inc_party"
void main()
{

object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetPartyInt(oPC, "hell3");

if (!(nInt == 0))
   return;

AssignCommand(oPC, ActionSpeakString("I must be getting close..."));
SetPartyInt(oPC, "hell3", 1);

}
