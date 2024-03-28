int StartingConditional()
{
object oPC = GetPCSpeaker();
if (!(GetLocalInt(oPC, "jarulf") == 1)) return FALSE;
return TRUE;
}

