#include "inc_party"
int StartingConditional()
{
object oPC = GetPCSpeaker();

if (!(GetPartyInt(oPC, "lazarusstaff") == 1)) return FALSE;

return TRUE;
}

