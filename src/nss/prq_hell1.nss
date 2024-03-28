#include "inc_party"
int StartingConditional()
{
object oPC = GetPCSpeaker();
if (!(GetPartyInt(oPC, "hell1") == 1)) return FALSE;
return TRUE;
}

