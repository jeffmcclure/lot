#include "inc_party"
void main()
{

object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_LIGHTS");
if (!(nInt >= 1))
   return;

nInt=GetPartyInt(oPC, "northlights");
if (!(nInt == 0))
   return;

SetPartyInt(oPC, "northlights", 1);
AssignCommand(oPC, ActionSpeakString("The strange lights seem to be stronger here... Perhaps I can find the answers inside that cave..."));

}
