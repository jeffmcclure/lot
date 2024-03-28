#include "inc_party"
int StartingConditional()
{
object oPC = GetPCSpeaker();
if (!(GetPartyInt(oPC, "nakrulnote1") == 0)) return FALSE;
return TRUE;
}

