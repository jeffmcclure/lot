int StartingConditional()
{
object oPC = GetPCSpeaker();

int nInt;
nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYQST_WARLORD");

if (!(nInt == 3))
   return FALSE;

if (!(GetLocalInt(oPC, "rackweapon") < 1)) return FALSE;

return TRUE;
}

