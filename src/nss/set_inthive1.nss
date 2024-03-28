#include "inc_party"
void main()
{

object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetPartyInt(oPC, "hive1");

if (!(nInt == 0))
   return;

//AssignCommand(oPC, ActionSpeakString("This place is dark with evil.  I must watch my step..."));
SetPartyInt(oPC, "hive1", 1);

}
