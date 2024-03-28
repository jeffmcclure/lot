int StartingConditional()
{
object oPC = GetPCSpeaker();

if (!(GetGold(oPC) >= 2500)) return FALSE;

return TRUE;
}

