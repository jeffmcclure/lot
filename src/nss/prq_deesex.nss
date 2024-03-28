#include "inc_party"
int StartingConditional()
{
object oPC = GetPCSpeaker();

if (!(GetPartyInt(oPC, "deese") == 0)) return FALSE;

int nInt;
nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_LOSTBOYS");

if (!(nInt < 1))
   return FALSE;

return TRUE;
}
