#include "inc_party"
void main()
{

object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_WORMS");
if (!(nInt == 1))
   return;

nInt=GetPartyInt(oPC, "cellartalk2");
if (!(nInt == 0))
   return;

SetPartyInt(oPC, "cellartalk2", 1);
AssignCommand(oPC, ActionSpeakString("That's strange, still no worms.  Maybe Pepin was just seeing things..."));

}
