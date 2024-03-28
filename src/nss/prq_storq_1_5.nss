int StartingConditional()
{
object oPC = GetPCSpeaker();

if (!(GetHitDice(oPC) <=  5)) return FALSE;
if (!(GetHitDice(oPC) >=  1)) return FALSE;

return TRUE;
}
