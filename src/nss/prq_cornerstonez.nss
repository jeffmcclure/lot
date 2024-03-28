
int StartingConditional()
{
object oPC = GetPCSpeaker();
if (GetItemPossessedBy(oPC, "spell_cornerstone") == OBJECT_INVALID) return FALSE;

return TRUE;
}

