#include "inc_party"
int StartingConditional()
{
object oPC = GetPCSpeaker();

if (!(GetPartyInt(oPC, "blindquest") < 5)) return FALSE;

if (!(GetPartyInt(oPC, "blindquest") > 0)) return FALSE;

return TRUE;
}

