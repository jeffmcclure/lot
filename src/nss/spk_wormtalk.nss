#include "inc_party"
void main()
{

object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_WORMS");
if (!(nInt < 2))
   return;

nInt=GetPartyInt(oPC, "wormtalk");
if (!(nInt == 0))
   return;

AssignCommand(oPC, ActionSpeakString("The worms are coming from this cellar.  I'll have to investigate."));
SetPartyInt(oPC, "wormtalk", 1);

}
