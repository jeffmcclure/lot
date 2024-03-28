#include "inc_party"
void main()
{

object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_NAKRUL");
if (!(nInt < 3))
   return;

nInt=GetPartyInt(oPC, "torntalk2");
if (!(nInt == 0))
   return;

AssignCommand(oPC, ActionSpeakString("There is a torn note lying on the ground.  I should pick it up!"));
SetPartyInt(oPC, "torntalk2", 1);

}
