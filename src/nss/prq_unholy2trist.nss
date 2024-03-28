#include "inc_party"
int StartingConditional()
{
object oPC = GetPCSpeaker();

if (!(GetPartyInt(oPC, "unholyportal") == 0)) return FALSE;

return TRUE;
}

