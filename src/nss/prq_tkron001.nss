int StartingConditional()
{
object oPC = GetPCSpeaker();
if (!(GetLocalInt(oPC, "tkron") == 1)) return FALSE;
return TRUE;
}

