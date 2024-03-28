int StartingConditional()
{
object oPC = GetPCSpeaker();

if (!(GetLocalInt(oPC, "lazarusjournal3") == 0)) return FALSE;

return TRUE;
}

