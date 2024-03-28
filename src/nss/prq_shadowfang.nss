#include "inc_party"
int StartingConditional()
{
object oPC = GetPCSpeaker();

int nInt;
nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_FLESHDOOM");
if (!(nInt == 3))
   return FALSE;

if (!(GetPartyInt(oPC, "fleshdone") == 0)) return FALSE;

return TRUE;
}

