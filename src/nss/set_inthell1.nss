#include "inc_party"
void main()
{

object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetPartyInt(oPC, "hell1");
if (!(nInt == 0))
   return;

AssignCommand(oPC, ActionSpeakString("It's hot down here..."));
SetPartyInt(oPC, "hell1", 1);

}
