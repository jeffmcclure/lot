int StartingConditional()
{
object oPC = GetPCSpeaker();

if (!(GetLocalInt(oPC, "startmodule") == 1)) return FALSE;

return TRUE;
}

