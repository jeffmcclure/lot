#include "inc_party"
int StartingConditional()
{
object oPC = GetPCSpeaker();

int nInt;
nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_MUSHROOM");

if (!(nInt == 3))
   return FALSE;

//if (!(nInt >= 3))
//   return FALSE;

//nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYQST_MUSHROOM");

//if (!(nInt < 4))
//   return FALSE;

if (GetItemPossessedBy(oPC, "D1_DEMONBRAIN") == OBJECT_INVALID) return FALSE;

return TRUE;
}
