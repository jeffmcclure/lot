int StartingConditional()
{
object oPC = GetPCSpeaker();

if (!(GetLocalInt(oPC, "nakruljournal6") == 0)) return FALSE;

return TRUE;
}

