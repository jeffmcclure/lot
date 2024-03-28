int StartingConditional()
{
object oPC = GetPCSpeaker();

if (!(GetLocalInt(oPC, "nakruljournal2") == 0)) return FALSE;

return TRUE;
}

