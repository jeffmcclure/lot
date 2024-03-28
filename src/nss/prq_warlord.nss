#include "inc_party"
int StartingConditional()
{
object oPC = GetPCSpeaker();

if (GetItemPossessedBy(oPC, "D1_STEELTOME") == OBJECT_INVALID) return FALSE;

int nInt;
nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_WARLORD");

if (!(nInt == 1))
   return FALSE;

return TRUE;
}

