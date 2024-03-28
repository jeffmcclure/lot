#include "inc_party"
int StartingConditional()
{
object oPC = GetPCSpeaker();

if (!(GetPartyInt(oPC, "tornjournal3") == 0)) return FALSE;

return TRUE;
}

