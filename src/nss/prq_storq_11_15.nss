int StartingConditional()
{
object oPC = GetPCSpeaker();

if (!(GetHitDice(oPC) <=  15)) return FALSE;
if (!(GetHitDice(oPC) >=  11)) return FALSE;

return TRUE;
}
