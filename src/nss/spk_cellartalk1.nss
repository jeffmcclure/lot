#include "inc_party"
void main()
{

object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_WORMS");
if (!(nInt == 1))
   return;

nInt=GetPartyInt(oPC, "cellartalk1");
if (!(nInt == 0))
   return;

SetPartyInt(oPC, "cellartalk1", 1);
AssignCommand(oPC, ActionSpeakString("Hmmm, no worms here ... maybe I can see them past that door..."));

}
