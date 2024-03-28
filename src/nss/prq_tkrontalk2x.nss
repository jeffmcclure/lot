#include "inc_party"
int StartingConditional()
{
object oPC = GetPCSpeaker();

int nInt;
nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYQST_TKRON");
if (!(nInt == 1))
   return FALSE;

if (!(GetPartyInt(oPC, "caverns1") == 1)) return FALSE;
if (!(GetLocalInt(oPC, "tkrontalk") == 1)) return FALSE;

return TRUE;
}

