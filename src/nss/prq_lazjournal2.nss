int StartingConditional()
{
object oPC = GetPCSpeaker();

if (!(GetLocalInt(oPC, "lazarusjournal2") == 0)) return FALSE;

return TRUE;
}

