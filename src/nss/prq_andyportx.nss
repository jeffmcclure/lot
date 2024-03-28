int StartingConditional()
{
object oPC = GetPCSpeaker();

if (GetItemPossessedBy(oPC, "andystone1") == OBJECT_INVALID) return FALSE;
if (GetItemPossessedBy(oPC, "andystone2") == OBJECT_INVALID) return FALSE;
if (GetItemPossessedBy(oPC, "andystone3") == OBJECT_INVALID) return FALSE;

return TRUE;
}

