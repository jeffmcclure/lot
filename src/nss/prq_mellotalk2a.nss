#include "inc_party"
int StartingConditional()
{
object oPC = GetPCSpeaker();

int nInt;
nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYQST_MELLO");
if (!(nInt == 1))
   return FALSE;

//if (!(GetPartyInt(oPC, "catacombs1") == 1)) return FALSE;
if (!(GetLocalInt(oPC, "mellotalk") == 1)) return FALSE;

return TRUE;
}

