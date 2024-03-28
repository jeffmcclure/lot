int StartingConditional()
{
object oPC = GetPCSpeaker();

if (GetItemPossessedBy(oPC, "D1_TAVERNSIGN") == OBJECT_INVALID) return FALSE;

return TRUE;
}

