int StartingConditional()
{
object oPC = GetPCSpeaker();

if (!(GetHitDice(oPC) >=  10)) return FALSE;

return TRUE;
}

