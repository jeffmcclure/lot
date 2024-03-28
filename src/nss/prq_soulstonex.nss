int StartingConditional()
{
object oPC = GetPCSpeaker();
if (GetItemPossessedBy(oPC, "spell_soulstone") == OBJECT_INVALID) return FALSE;

return TRUE;
}

