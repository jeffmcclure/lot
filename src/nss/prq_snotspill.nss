#include "inc_party"
int StartingConditional()
{
object oPC = GetPCSpeaker();

int nInt;
nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_OGDENSIGN");

if (!(nInt >= 2))
   return FALSE;

return TRUE;
}
