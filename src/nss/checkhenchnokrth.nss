
#include "x0_i0_henchman"

int StartingConditional()
{
object oPC = GetPCSpeaker();
object oTarget1 = GetHenchman(oPC,1);
object oTarget2 = GetHenchman(oPC,2);

if (GetTag(oTarget1) == "kirath") return FALSE;

if (GetTag(oTarget2) == "kirath") return FALSE;

return TRUE;
}

