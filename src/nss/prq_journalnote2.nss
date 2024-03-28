#include "inc_party"
int StartingConditional()
{
object oPC = GetPCSpeaker();

if (!(GetPartyInt(oPC, "tornjournal2") == 0)) return FALSE;

return TRUE;
}

