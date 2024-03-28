int StartingConditional()
{
object oPC = GetPCSpeaker();

if (!(GetLocalInt(oPC, "darkexile") == 1)) return FALSE;

return TRUE;
}

