int StartingConditional()
{
object oPC = GetPCSpeaker();

int nInt;
nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYQST_JARULF");
if (!(nInt < 1))
   return FALSE;

if (!(GetLocalInt(oPC, "catacombs1") == 1)) return FALSE;
if (!(GetLocalInt(oPC, "jarulftalk") == 0)) return FALSE;

return TRUE;
}

