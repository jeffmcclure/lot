int StartingConditional()
{
object oPC = GetPCSpeaker();
if (!(GetHitDice(oPC) >=  18)) return FALSE;

return TRUE;
}

