#include "inc_party"
int StartingConditional()
{
object oPC = GetPCSpeaker();

int nInt;
nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_ISLAND");

if (!(nInt == 1))
   return FALSE;

nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_ISLAND");

if (!(nInt < 4))
   return FALSE;

return TRUE;
}

