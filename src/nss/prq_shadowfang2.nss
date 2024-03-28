#include "inc_party"
int StartingConditional()
{
object oPC = GetPCSpeaker();

int nInt;
nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_SHADOWFANG");

if (!(nInt >= 2))
   return FALSE;

nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_SHADOWFANG");

if (!(nInt < 3))
   return FALSE;

if (GetItemPossessedBy(oPC, "shadowfang") == OBJECT_INVALID) return FALSE;

return TRUE;
}

