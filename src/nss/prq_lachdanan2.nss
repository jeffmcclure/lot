#include "inc_party"
int StartingConditional()
{
object oPC = GetPCSpeaker();

int nInt;
nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_LACHDANAN");

if (!(nInt >= 2))
   return FALSE;

nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_LACHDANAN");

if (!(nInt < 3))
   return FALSE;

if (GetItemPossessedBy(oPC, "D1_GOLDENELIXIR") == OBJECT_INVALID) return FALSE;

return TRUE;
}

