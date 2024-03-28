int StartingConditional()
{
object oPC = GetPCSpeaker();

int nInt;
nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYQST_JARULF");
if (!(nInt == 1))
   return FALSE;

//if (!(GetLocalInt(oPC, "caverns1") == 1)) return FALSE;
if (!(GetLocalInt(oPC, "jarulftalk") == 1)) return FALSE;

return TRUE;
}

