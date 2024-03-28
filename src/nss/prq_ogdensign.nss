#include "inc_party"
int StartingConditional()
{
object oPC = GetPCSpeaker();

int nInt;
nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_OGDENSIGN");

if (!(nInt < 1))
   return FALSE;

nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_MAGICBANNER");

if (!(nInt < 1))
   return FALSE;

if (!(GetPartyInt(oPC, "cathedral2") == 1)) return FALSE;

return TRUE;
}
