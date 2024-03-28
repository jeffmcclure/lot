int StartingConditional()
{
object oPC = GetPCSpeaker();
if (GetItemPossessedBy(oPC, "D1_BUTCHERSCLEAVER") == OBJECT_INVALID) return FALSE;

return TRUE;
}

