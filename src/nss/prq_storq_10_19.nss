int StartingConditional()
{
object oPC = GetPCSpeaker();

if (!(GetHitDice(oPC) >=  10)) return FALSE;
if (!(GetHitDice(oPC) <=  19)) return FALSE;

return TRUE;
}

