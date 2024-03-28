int StartingConditional()
{
object oPC = GetPCSpeaker();
if (!(GetHitDice(oPC) >=  19)) return FALSE;

return TRUE;
}

