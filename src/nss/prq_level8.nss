int StartingConditional()
{
object oPC = GetPCSpeaker();

if (!(GetHitDice(oPC) >=  8)) return FALSE;

return TRUE;
}

