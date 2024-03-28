#include "nw_i0_tool"

int StartingConditional()
{
object oPC = GetPCSpeaker();

object oTarget1 = GetHenchman(oPC,1);
object oTarget2 = GetHenchman(oPC,2);

if (GetTag(oTarget1) == "taghor") return TRUE;

if (GetTag(oTarget2) == "taghor") return TRUE;

return FALSE;

}

