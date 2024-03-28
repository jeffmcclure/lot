#include "inc_party"
void main()
{

object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_WATERSUPPLY");
if (!(nInt < 2))
   return;

nInt=GetPartyInt(oPC, "watertalk");
if (!(nInt == 0))
   return;

AssignCommand(oPC, ActionSpeakString("This must be the underground spring Pepin was talking about - these creatures have tainted it!"));
SetPartyInt(oPC, "watertalk", 1);

}
