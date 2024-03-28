int StartingConditional()
{
object oPC = GetPCSpeaker();
if (GetItemPossessedBy(oPC, "D1_THEODORE") == OBJECT_INVALID) return FALSE;

return TRUE;
}

