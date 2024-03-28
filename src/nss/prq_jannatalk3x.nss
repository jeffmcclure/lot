#include "inc_party"
int StartingConditional()
{
object oPC = GetPCSpeaker();

int nInt;
nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYQST_JANNA");
if (!(nInt < 3))
   return FALSE;

if (!(GetPartyInt(oPC, "caverns1") == 1)) return FALSE;
if (!(GetLocalInt(oPC, "jannatalk") == 2)) return FALSE;
if (!(GetHitDice(oPC) >=  20)) return FALSE;

return TRUE;
}
