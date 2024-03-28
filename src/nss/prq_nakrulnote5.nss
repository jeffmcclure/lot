#include "inc_party"
int StartingConditional()
{
object oPC = GetPCSpeaker();
if (!(GetPartyInt(oPC, "nakrulnote5") == 0)) return FALSE;
return TRUE;
}

