#include "inc_party"
int StartingConditional()
{
object oPC = GetPCSpeaker();

int nInt;
nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_COW");

if (!(nInt >= 1))
   return FALSE;

return TRUE;
}

