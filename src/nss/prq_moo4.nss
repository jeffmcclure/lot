#include "inc_party"
int StartingConditional()
{
object oPC = GetPCSpeaker();

if (!(GetPartyInt(oPC, "moo") == 4)) return FALSE;

return TRUE;
}

