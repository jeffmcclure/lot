#include "inc_party"
void main()
{

object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_ANDARIEL");
if (!(nInt < 2))
   return;

nInt=GetPartyInt(oPC, "andytalk");
if (!(nInt == 0))
   return;

nInt=GetPartyInt(oPC, "andariel");
if (!(nInt == 1))
   return;

AssignCommand(oPC, ActionSpeakString("This portal leads to Andariel's lair.  I should cast a portal here, in case I can't get back!"));
SetPartyInt(oPC, "andytalk", 1);

}
