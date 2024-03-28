#include "inc_party"
int StartingConditional()
{
object oPC = GetPCSpeaker();

int nInt;
nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_WORMS");

if (!(nInt < 1))
   return FALSE;

if (!(GetPartyInt(oPC, "catacombs1") == 1)) return FALSE;

return TRUE;
}

