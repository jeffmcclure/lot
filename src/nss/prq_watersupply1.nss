#include "inc_party"
int StartingConditional()
{
object oPC = GetPCSpeaker();

if (!(GetPartyInt(oPC, "watersupplyquest") < 1)) return FALSE;

return TRUE;
}

