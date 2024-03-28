int StartingConditional()
{
object oPC = GetPCSpeaker();
if (!(GetLocalInt(oPC, "barnhouse") == 1)) return FALSE;

return TRUE;
}

