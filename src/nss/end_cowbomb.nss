int StartingConditional()
{
object oPC = GetPCSpeaker();

if (!(GetLocalInt(oPC, "cowbomb") == 1)) return FALSE;

int nInt;
nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYQST_ORCHARD");

if (!(nInt < 2))
   return FALSE;

return TRUE;
}
