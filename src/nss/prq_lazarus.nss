#include "inc_party"
int StartingConditional()
{
object oPC = GetPCSpeaker();

if (GetItemPossessedBy(oPC, "KEY_LAZARUS_STAFF") == OBJECT_INVALID) return FALSE;

//int nInt;
//nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_LAZARUS");

//if (!(nInt == 1))
//   return FALSE;

return TRUE;
}
