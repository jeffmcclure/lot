int StartingConditional()
{
object oPC = GetPCSpeaker();

int nInt;
nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYQST_ARKAINE");

if (!(nInt == 1))
   return FALSE;

//nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYQST_ARKAINE");

//if (!(nInt < 3))
//   return FALSE;

return TRUE;
}

