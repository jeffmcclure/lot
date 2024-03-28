int StartingConditional()
{
object oPC = GetPCSpeaker();
if (GetItemPossessedBy(oPC, "HIVE_BOMB") == OBJECT_INVALID) return FALSE;
return TRUE;
}

