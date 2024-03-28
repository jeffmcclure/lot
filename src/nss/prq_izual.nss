#include "inc_party"
int StartingConditional()
{
object oPC = GetPCSpeaker();

int nInt;
nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_IZUAL");
if (!(nInt < 1))
   return FALSE;

nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_ISLAND");
if (!(nInt >= 3))
   return FALSE;

if (!(GetPartyInt(oPC, "caverns1") == 1)) return FALSE;

return TRUE;
}

