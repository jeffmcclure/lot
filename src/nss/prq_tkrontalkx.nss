int StartingConditional()
{
object oPC = GetPCSpeaker();

int nInt;
nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYQST_TKRON");
if (!(nInt == 3))
   return FALSE;

if (!(GetLocalInt(oPC, "tkrontalk") == 3)) return FALSE;

return TRUE;
}

