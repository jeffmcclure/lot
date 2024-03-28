int StartingConditional()
{
object oPC = GetPCSpeaker();

if (!(GetLocalInt(oPC, "arkaine") == 5)) return FALSE;

return TRUE;
}

