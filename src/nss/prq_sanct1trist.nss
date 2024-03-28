#include "inc_party"
int StartingConditional()
{
object oPC = GetPCSpeaker();

if (!(GetPartyInt(oPC, "innersanctum1") == 0)) return FALSE;

return TRUE;
}

