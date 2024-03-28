int StartingConditional()
{
object oPC = GetPCSpeaker();

if (GetItemPossessedBy(oPC, "dmfi_pc_emote") == OBJECT_INVALID) return FALSE;

return TRUE;
}

