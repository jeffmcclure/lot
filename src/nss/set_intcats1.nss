#include "inc_party"
void main()
{

object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetPartyInt(oPC, "catacombs1");
if (!(nInt == 0))
   return;

AssignCommand(oPC, ActionSpeakString("The smell of death surrounds me..."));
SetPartyInt(oPC, "catacombs1", 1);

}
