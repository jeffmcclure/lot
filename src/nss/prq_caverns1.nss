#include "inc_party"
int StartingConditional()
{
object oPC = GetPCSpeaker();
if (!(GetPartyInt(oPC, "caverns1") == 1)) return FALSE;
return TRUE;
}

