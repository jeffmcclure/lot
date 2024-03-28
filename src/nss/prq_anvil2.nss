int StartingConditional()
{
object oPC = GetPCSpeaker();

int nInt;
nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYQST_ANVIL");

if (!(nInt == 2))
   return FALSE;

if (GetItemPossessedBy(oPC, "D1_ANVILOFFURY") == OBJECT_INVALID) return FALSE;

return TRUE;
}
