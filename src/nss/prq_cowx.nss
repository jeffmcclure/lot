int StartingConditional()
{
object oPC = GetPCSpeaker();

if (!(GetHitDice(oPC) <=  14)) return FALSE;

return TRUE;
}

