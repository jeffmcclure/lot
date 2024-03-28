int StartingConditional()
{
object oPC = GetPCSpeaker();
if (!(GetLocalInt(oPC, "janna") == 1)) return FALSE;
return TRUE;
}

