#include "inc_party"
int StartingConditional()
{
object oPC = GetPCSpeaker();

int nInt;
nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_ZHAR");

if (!(nInt < 2))
   return FALSE;

if (!(GetPartyInt(oPC, "zhar") == 2)) return FALSE;

return TRUE;
}

