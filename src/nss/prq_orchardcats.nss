#include "inc_party"
int StartingConditional()
{
object oPC = GetPCSpeaker();
if (!(GetPartyInt(oPC, "catacombs1") == 1)) return FALSE;

int nInt;
nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYQST_ORCHARD");

if (!(nInt < 1))
   return FALSE;

return TRUE;
}

