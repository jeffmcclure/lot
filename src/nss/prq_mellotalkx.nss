int StartingConditional()
{
object oPC = GetPCSpeaker();

int nInt;
nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYQST_MELLO");
if (!(nInt == 3))
   return FALSE;

if (!(GetLocalInt(oPC, "mellotalk") == 3)) return FALSE;

return TRUE;
}

