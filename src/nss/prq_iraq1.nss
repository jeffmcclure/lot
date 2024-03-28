int StartingConditional()
{
object oPC = GetPCSpeaker();

int nInt;
nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYQST_IRAQ");
if (!(nInt < 1))
   return FALSE;

return TRUE;
}

