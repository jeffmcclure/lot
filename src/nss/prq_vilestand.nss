#include "inc_party"
int StartingConditional()
{
object oPC = GetPCSpeaker();

if (GetItemPossessedBy(oPC, "KEY_LAZARUS_STAFF") == OBJECT_INVALID) return FALSE;

if (!(GetPartyInt(oPC, "lazarus") > 0)) return FALSE;

return TRUE;
}

