#include "inc_party"
int StartingConditional()
{
object oPC = GetPCSpeaker();

int nInt;
nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_MUSHROOM");

if (!(nInt < 1))
   return FALSE;

if (GetItemPossessedBy(oPC, "D1_FUNGALTOME") == OBJECT_INVALID) return FALSE;

return TRUE;
}

