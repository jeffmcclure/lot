int StartingConditional()
{
object oPC = GetPCSpeaker();

if (!(GetGold(oPC) >= 500)) return FALSE;

return TRUE;
}

