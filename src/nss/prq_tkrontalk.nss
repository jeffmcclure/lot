int StartingConditional()
{
object oPC = GetPCSpeaker();
if (!(GetLocalInt(oPC, "tkrontalk") == 0)) return FALSE;

return TRUE;
}

