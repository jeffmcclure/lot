int StartingConditional()
{
object oPC = GetPCSpeaker();

int nInt;
nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYQST_JARULF");
if (!(nInt == 3))
   return FALSE;

if (!(GetLocalInt(oPC, "jarulftalk") == 3)) return FALSE;

return TRUE;
}

