#include "inc_party"
int StartingConditional()
{
object oPC = GetPCSpeaker();

if (!(GetPartyInt(oPC, "tornjournal1") == 0)) return FALSE;

return TRUE;
}

