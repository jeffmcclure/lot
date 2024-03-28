int StartingConditional()
{
object oPC = GetPCSpeaker();
if (!(GetLocalInt(oPC, "mello") == 1)) return FALSE;
return TRUE;
}

