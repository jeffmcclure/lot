#include "inc_party"
void main()
{

object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetPartyInt(oPC, "caverns1");

if (!(nInt == 0))
   return;

AssignCommand(oPC, ActionSpeakString("This place is dark with evil.  I must watch my step..."));
SetPartyInt(oPC, "caverns1", 1);

}
