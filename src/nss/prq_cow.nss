#include "inc_party"
int StartingConditional()
{
object oPC = GetPCSpeaker();

if (!(GetHitDice(oPC) >=  14)) return FALSE;
return TRUE;

int nInt;
nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_ORCHARD");
if (!(nInt == 2))
   return FALSE;

return TRUE;

nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_COW");
if (!(nInt < 1))
   return FALSE;

return TRUE;
}

