#include "inc_party"
int StartingConditional()
{
object oPC = GetPCSpeaker();

if (!(GetPartyInt(oPC, "catacombs1") == 1)) return FALSE;

int nInt;
nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_FLESHDOOM");

if (!(nInt < 1))
   return FALSE;

return TRUE;
}

