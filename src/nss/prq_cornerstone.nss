#include "inc_party"
int StartingConditional()
{
object oPC = GetPCSpeaker();

if (!(GetPartyInt(oPC, "cornerstonequest") < 5)) return FALSE;

return TRUE;
}
