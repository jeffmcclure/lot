#include "inc_party"
int StartingConditional()
{
object oPC = GetPCSpeaker();

if (!(GetPartyInt(oPC, "cowbomb") < 1)) return FALSE;

return TRUE;
}

