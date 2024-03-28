#include "inc_party"
int StartingConditional()
{
object oPC = GetPCSpeaker();
//if (!(GetPartyInt(oPC, "catacombs1") == 1)) return FALSE;

int nInt;
nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_ISLAND");

if (!(nInt >= 3))
   return FALSE;

return TRUE;
}
