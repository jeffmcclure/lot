int StartingConditional()
{
object oPC = GetPCSpeaker();

if (!(GetHitDice(oPC) <=  10)) return FALSE;
if (!(GetHitDice(oPC) >=  6)) return FALSE;

return TRUE;
}
