#include "inc_party"
int StartingConditional()
{
object oPC = GetPCSpeaker();

if (!(GetPartyInt(oPC, "moo") == 2)) return FALSE;

return TRUE;
}

