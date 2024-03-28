#include "inc_party"
void main()
{

object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_CHAMBER");
if (!(nInt >= 1))
   return;

nInt=GetPartyInt(oPC, "chambertalk");
if (!(nInt == 0))
   return;

AssignCommand(oPC, ActionSpeakString("I may get trapped in this chamber.  Casting a portal here would be a good idea..."));
SetPartyInt(oPC, "chambertalk", 1);

}
