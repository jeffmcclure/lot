#include "inc_party"
int StartingConditional()
{
object oPC = GetPCSpeaker();
if (!(GetPartyInt(oPC, "cowmantalk2") == 1)) return FALSE;

return TRUE;
}

