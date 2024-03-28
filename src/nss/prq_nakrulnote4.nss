#include "inc_party"
int StartingConditional()
{
object oPC = GetPCSpeaker();
if (!(GetPartyInt(oPC, "nakrulnote4") == 0)) return FALSE;
return TRUE;
}

