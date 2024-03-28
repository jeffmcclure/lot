int StartingConditional()
{
object oPC = GetPCSpeaker();

if (!(GetGold(oPC) >= 25)) return FALSE;

return TRUE;
}

