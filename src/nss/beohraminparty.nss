#include "nw_i0_tool"

int StartingConditional()
{
object oPC = GetPCSpeaker();

object oTarget1 = GetHenchman(oPC,1);
object oTarget2 = GetHenchman(oPC,2);

if (GetTag(oTarget1) == "beohram") return TRUE;

if (GetTag(oTarget2) == "beohram") return TRUE;

return FALSE;

}

