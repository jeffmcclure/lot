#include "inc_party"
int StartingConditional()
{
object oPC = GetPCSpeaker();
if (!(GetPartyInt(oPC, "nadine") >= 2)) return FALSE;

return TRUE;
}

