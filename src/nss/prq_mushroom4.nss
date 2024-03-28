#include "inc_party"
int StartingConditional()
{
object oPC = GetPCSpeaker();

int nInt;
nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_MUSHROOM");

if (!(nInt == 4))
   return FALSE;

//nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYQST_MUSHROOM");

//if (!(nInt < 5))
//   return FALSE;

if (GetItemPossessedBy(oPC, "D1_SPECTRALELIXIRFAKE") == OBJECT_INVALID) return FALSE;

return TRUE;
}
