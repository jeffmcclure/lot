#include "inc_party"
int StartingConditional()
{
object oPC = GetPCSpeaker();

int nInt;
nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYQST_MELLO");
if (!(nInt < 3))
   return FALSE;

if (!(GetPartyInt(oPC, "caverns1") == 1)) return FALSE;
if (!(GetLocalInt(oPC, "mellotalk") == 2)) return FALSE;
if (GetItemPossessedBy(oPC, "D1_DEFILERHEART") == OBJECT_INVALID) return FALSE;

return TRUE;
}
