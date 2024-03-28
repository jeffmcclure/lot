#include "inc_party"
int StartingConditional()
{
object oPC = GetPCSpeaker();
if (!(GetPartyInt(oPC, "knowfarnham") == 1)) return FALSE;

return TRUE;
}

