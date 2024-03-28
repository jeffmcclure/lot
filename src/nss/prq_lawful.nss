int StartingConditional()
{
object oPC = GetPCSpeaker();

if (!(GetAlignmentLawChaos(oPC) == ALIGNMENT_LAWFUL)) return FALSE;

return TRUE;
}

