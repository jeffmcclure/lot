#include "inc_party"
void main()
{

object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_DIABLO");
if (!(nInt < 3))
   return;

nInt=GetPartyInt(oPC, "diablotalkx");
if (!(nInt == 0))
   return;

AssignCommand(oPC, ActionSpeakString("This portal leads to the Lord of Terror himself.  I should cast a portal here, in case I can't get back!"));
SetPartyInt(oPC, "diablotalkx", 1);

}
