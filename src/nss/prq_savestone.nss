int StartingConditional()
{
object oPC = GetPCSpeaker();

if (GetItemPossessedBy(oPC, "save_stone") == OBJECT_INVALID) return FALSE;

return TRUE;
}

