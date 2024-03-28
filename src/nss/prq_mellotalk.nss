int StartingConditional()
{
object oPC = GetPCSpeaker();
if (!(GetLocalInt(oPC, "mellotalk") == 0)) return FALSE;

return TRUE;
}

