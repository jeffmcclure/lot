#include "inc_party"
int StartingConditional()
{
object oPC = GetPCSpeaker();

int nInt;
nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYQST_JANNA");
if (!(nInt < 1))
   return FALSE;

if (!(GetPartyInt(oPC, "catacombs1") == 1)) return FALSE;
if (!(GetLocalInt(oPC, "jannatalk") == 0)) return FALSE;

return TRUE;
}

