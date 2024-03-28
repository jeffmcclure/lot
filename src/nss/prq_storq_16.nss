int StartingConditional()
{
object oPC = GetPCSpeaker();

if (!(GetHitDice(oPC) >=  16)) return FALSE;

return TRUE;
}

