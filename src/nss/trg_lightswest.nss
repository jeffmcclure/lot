#include "inc_party"
void main()
{

object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_LIGHTS");
if (!(nInt >= 1))
   return;

nInt=GetPartyInt(oPC, "forestlights");
if (!(nInt == 0))
   return;

SetPartyInt(oPC, "forestlights", 1);
AssignCommand(oPC, ActionSpeakString("This must be the strange lights Gillian mentioned... I wonder where they lead to?"));

}
