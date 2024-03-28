int StartingConditional()
{
object oPC = GetPCSpeaker();

if (!(GetLocalInt(oPC, "nakruljournal3") == 0)) return FALSE;

return TRUE;
}

