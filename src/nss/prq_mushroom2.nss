#include "inc_party"
int StartingConditional()
{
object oPC = GetPCSpeaker();

if (GetItemPossessedBy(oPC, "D1_BLACKMUSHROOM") == OBJECT_INVALID) return FALSE;

int nInt;
nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_MUSHROOM");

if (!(nInt == 2))
   return FALSE;

//if (!(nInt >= 2))
//   return FALSE;

//nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYQST_MUSHROOM");

//if (!(nInt < 3))
//   return FALSE;

return TRUE;
}
