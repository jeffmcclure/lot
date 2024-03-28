#include "inc_party"
void main()
{

object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_LAZARUS");
if (!(nInt >= 3))
   return;

nInt=GetPartyInt(oPC, "fakealtalk");
if (!(nInt == 0))
   return;

AssignCommand(oPC, ActionSpeakString("There is a dead boy on this altar... it seems that you were too late to save the missing prince..."));
SetPartyInt(oPC, "fakealtalk", 1);

}

