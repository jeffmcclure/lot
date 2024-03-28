#include "inc_party"
int StartingConditional()
{
object oPC = GetPCSpeaker();
if (!(GetPartyInt(oPC, "endtremayne") == 1)) return FALSE;

return TRUE;
}

