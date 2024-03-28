#include "inc_party"
int StartingConditional()
{
object oPC = GetPCSpeaker();

if (!(GetPartyInt(oPC, "butcherquest") < 2)) return FALSE;

return TRUE;
}

