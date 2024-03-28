int StartingConditional()
{
object oPC = GetPCSpeaker();

if (GetItemPossessedBy(oPC, "D1_AZUREWRATH") == OBJECT_INVALID) return FALSE;
if (!(GetLocalInt(oPC, "azuregone") == 0)) return FALSE;

return TRUE;
}

