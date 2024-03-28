int StartingConditional()
{
object oPC = GetPCSpeaker();

if (!(GetLocalInt(oPC, "nakruljournal5") == 0)) return FALSE;

return TRUE;
}

