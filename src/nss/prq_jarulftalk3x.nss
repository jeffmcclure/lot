int StartingConditional()
{
object oPC = GetPCSpeaker();

int nInt;
nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYQST_JARULF");
if (!(nInt < 3))
   return FALSE;

if (!(GetLocalInt(oPC, "caverns1") == 1)) return FALSE;
if (!(GetLocalInt(oPC, "jarulftalk") == 2)) return FALSE;
if (!(GetGold(oPC) >= 500000)) return FALSE;

return TRUE;
}
