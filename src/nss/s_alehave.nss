int StartingConditional()
{
object oPC = GetPCSpeaker();

if (GetItemPossessedBy(oPC, "NW_IT_MPOTION021") == OBJECT_INVALID) return FALSE;

return TRUE;
}

