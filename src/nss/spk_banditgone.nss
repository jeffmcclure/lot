#include "inc_party"
void main()
{

object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_ANDARIEL");
if (!(nInt >= 3))
   return;

nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_BANDIT");
if (!(nInt >= 3))
   return;

nInt=GetPartyInt(oPC, "banditgonex");
if (!(nInt == 0))
   return;

AssignCommand(oPC, ActionSpeakString("Hmmm, the bandits have left this camp.  I guess that means the evil in these forests is truly gone..."));
SetPartyInt(oPC, "banditgonex", 1);

}
