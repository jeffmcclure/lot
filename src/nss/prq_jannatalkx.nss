int StartingConditional()
{
object oPC = GetPCSpeaker();

int nInt;
nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYQST_JANNA");
if (!(nInt == 3))
   return FALSE;

if (!(GetLocalInt(oPC, "jannatalk") == 3)) return FALSE;

return TRUE;
}

