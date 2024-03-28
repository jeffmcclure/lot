int StartingConditional()
{
object oPC = GetPCSpeaker();
if (!(GetLocalInt(oPC, "jarulftalk") == 0)) return FALSE;

return TRUE;
}

