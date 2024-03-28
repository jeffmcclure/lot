int StartingConditional()
{
object oPC = GetPCSpeaker();

if (!(GetGold(oPC) >= 2000)) return FALSE;

return TRUE;
}

