int StartingConditional()
{
object oPC = GetPCSpeaker();

if (!(GetLocalInt(oPC, "nakruljournal1") == 0)) return FALSE;

return TRUE;
}

