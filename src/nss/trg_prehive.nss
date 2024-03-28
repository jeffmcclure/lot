#include "inc_party"
void main()
{

object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_DEFILER");
if (!(nInt < 3))
   return;

nInt=GetPartyInt(oPC, "prehive");
if (!(nInt == 0))
   return;

SetPartyInt(oPC, "prehive", 1);
AssignCommand(oPC, ActionSpeakString("There are things moving below this pit."));

}
