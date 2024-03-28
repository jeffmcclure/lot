#include "inc_party"
int StartingConditional()
{
object oPC = GetPCSpeaker();

 if (GetItemPossessedBy(oPC, "D1_CATHEDRALMAP") == OBJECT_INVALID) return FALSE;

int nInt;
nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_GRAVEMATTERS");
if (!(nInt < 1))
   return FALSE;

if (!(GetPartyInt(oPC, "cathedralmap") == 1)) return FALSE;

return TRUE;
}

