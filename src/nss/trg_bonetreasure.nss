#include "inc_party"
void main()
{

object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_CHAMBER");
if (!(nInt == 2))
   return;

nInt=GetPartyInt(oPC, "bonetreasure");
if (!(nInt == 0))
   return;

SetPartyInt(oPC, "bonetreasure", 1);
AssignCommand(oPC, ActionSpeakString("This must be the treasure room..."));

}
