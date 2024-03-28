int StartingConditional()
{
object oPC = GetPCSpeaker();

if (!(GetLocalInt(oPC, "lazarusjournal1") == 0)) return FALSE;

return TRUE;
}

