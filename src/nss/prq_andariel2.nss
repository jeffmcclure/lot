#include "inc_party"
int StartingConditional()
{
object oPC = GetPCSpeaker();

int nInt;
nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_ANDARIEL");

if (!(nInt == 1))
   return FALSE;

//nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYQST_ANDARIEL");

//if (!(nInt < 3))
//   return FALSE;

return TRUE;
}

