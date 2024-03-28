int StartingConditional()
{
object oPC = GetPCSpeaker();

if (!(GetLocalInt(oPC, "greatconflict") == 1)) return FALSE;

return TRUE;
}

