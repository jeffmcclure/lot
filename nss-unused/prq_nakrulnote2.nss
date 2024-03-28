#include "inc_party"
int StartingConditional()
{
object oPC = GetPCSpeaker();
if (!(GetPartyInt(oPC, "nakrulnote2") == 0)) return FALSE;
return TRUE;
}

