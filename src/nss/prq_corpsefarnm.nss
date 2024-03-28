#include "inc_party"
int StartingConditional()
{
object oPC = GetPCSpeaker();

int nInt;
nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_ISLAND");

if (!(nInt == 3))
   return FALSE;

if (GetItemPossessedBy(oPC, "D1_CORPSEFARNHAM") == OBJECT_INVALID) return FALSE;

return TRUE;
}

