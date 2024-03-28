int StartingConditional()
{
object oPC = GetPCSpeaker();

if (!(GetGold(oPC) >= 3000)) return FALSE;

return TRUE;
}

