int StartingConditional()
{
object oPC = GetPCSpeaker();

int nInt;
nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYQST_COW");

if (!(nInt >= 2))
   return FALSE;

return TRUE;
}

