int StartingConditional()
{
object oPC = GetPCSpeaker();

if (GetItemPossessedBy(oPC, "D1_MODULEMANUAL") == OBJECT_INVALID) return FALSE;

return TRUE;
}

