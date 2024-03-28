#include "inc_party"
int StartingConditional()
{
object oPC = GetPCSpeaker();

if (GetItemPossessedBy(oPC, "D1_CORPSEROOF") == OBJECT_INVALID) return FALSE;
if (GetItemPossessedBy(oPC, "D1_CORPSEINNEAS") == OBJECT_INVALID) return FALSE;

int nInt;
nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_LOSTBOYS");
if (!(nInt == 3))
   return FALSE;

return TRUE;
}


