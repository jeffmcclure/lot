#include "inc_party"
int StartingConditional()
{
object oPC = GetPCSpeaker();

if (!(GetPartyInt(oPC, "cowtalk") == 1)) return FALSE;
if (!(GetPartyInt(oPC, "cowmantalk") == 0)) return FALSE;

return TRUE;
}

