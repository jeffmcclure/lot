#include "inc_party"
int StartingConditional()
{
object oPC = GetPCSpeaker();

if (!(GetPartyInt(oPC, "bonequest") < 5)) return FALSE;

return TRUE;
}
