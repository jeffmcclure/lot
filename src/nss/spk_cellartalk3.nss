#include "inc_party"
void main()
{

object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_WORMS");
if (!(nInt == 1))
   return;

nInt=GetPartyInt(oPC, "cellartalk3");
if (!(nInt == 0))
   return;

SetPartyInt(oPC, "cellartalk3", 1);
AssignCommand(oPC, ActionSpeakString("This section of the area is sealed off, like it caved in or something.  Maybe these worms are gone...  Time to move on..."));
AddJournalQuestEntry("QST_WORMS", 3, oPC, TRUE, FALSE);

}
