int StartingConditional()
{
object oPC = GetPCSpeaker();
if (GetItemPossessedBy(oPC, "D1_UNDEADCROWN") == OBJECT_INVALID) return FALSE;

return TRUE;
}

