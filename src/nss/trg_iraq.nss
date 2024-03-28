#include "inc_party"
void main()
{

object oPC = GetLastUsedBy();
if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_IRAQ");
if (!(nInt == 1))
   return;

nInt=GetPartyInt(oPC, "bush");
if (!(nInt == 0))
   return;

SetPartyInt(oPC, "bush", 1);
CreateItemOnObject("iraqoil", OBJECT_SELF);
AssignCommand(oPC, ActionSpeakString("Hmmm, there are no weapons here..."));

}

