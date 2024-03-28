#include "inc_party"
void main()
{

object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetPartyInt(oPC, "jailtalk");
if (!(nInt == 0))
   return;

nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_LOSTBOYS");
if (nInt < 3)
   {
   AssignCommand(oPC, ActionSpeakString("This jail area looks more like a feeding kennel... I see bodies inside - maybe some are still alive!"));
   SetPartyInt(oPC, "jailtalk", 1);

   }
else
   {
   AssignCommand(oPC, ActionSpeakString("This jail area looks more like a feeding kennel... I see bodies inside - maybe some are still alive!"));
   SetPartyInt(oPC, "jailtalk", 1);

   }

}
