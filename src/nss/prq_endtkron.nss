int StartingConditional()
{
object oPC = GetPCSpeaker();

if (GetItemPossessedBy(oPC, "D1_THEBINDINGOFTHETHREE") == OBJECT_INVALID) return FALSE;
if (GetItemPossessedBy(oPC, "D1_THEDARKEXILE") == OBJECT_INVALID) return FALSE;
if (GetItemPossessedBy(oPC, "D1_THEGREATCONFLICT") == OBJECT_INVALID) return FALSE;
if (GetItemPossessedBy(oPC, "D1_THESINWAR") == OBJECT_INVALID) return FALSE;
if (GetItemPossessedBy(oPC, "D1_LAZARUSJOURNAL1") == OBJECT_INVALID) return FALSE;
if (GetItemPossessedBy(oPC, "D1_LAZARUSJOURNAL2") == OBJECT_INVALID) return FALSE;
if (GetItemPossessedBy(oPC, "D1_LAZARUSJOURNAL3") == OBJECT_INVALID) return FALSE;

int nInt;
nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYQST_TKRON");
if (!(nInt >= 2))
   return FALSE;

return TRUE;
}
