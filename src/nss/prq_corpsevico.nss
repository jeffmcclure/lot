int StartingConditional()
{
object oPC = GetPCSpeaker();

if (GetItemPossessedBy(oPC, "D1_CORPSEVICO") == OBJECT_INVALID) return FALSE;

return TRUE;
}

