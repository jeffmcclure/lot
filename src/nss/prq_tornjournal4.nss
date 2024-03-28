int StartingConditional()
{
object oPC = GetPCSpeaker();

if (!(GetLocalInt(oPC, "nakruljournal4") == 0)) return FALSE;

return TRUE;
}

