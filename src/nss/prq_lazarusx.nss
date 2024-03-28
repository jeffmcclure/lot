#include "inc_party"
int StartingConditional()
{
object oPC = GetPCSpeaker();

int nInt;
//nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_BUTCHER");
//
//if (!(nInt >= 2))
//   return FALSE;
//
nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_LAZARUS");

if (!(nInt < 2))
   return FALSE;

return TRUE;
}

