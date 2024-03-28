#include "inc_party"
int StartingConditional()
{
object oPC = GetPCSpeaker();

int nInt;
nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_MAGICROCK");

if (!(nInt >= 1))
   return FALSE;

if (GetItemPossessedBy(oPC, "D1_HEAVENSTONE") == OBJECT_INVALID) return FALSE;

return TRUE;
}
