#include "inc_party"
int StartingConditional()
{
object oPC = GetPCSpeaker();

if (!(GetPartyInt(oPC, "hellforge") < 5)) return FALSE;

return TRUE;
}

