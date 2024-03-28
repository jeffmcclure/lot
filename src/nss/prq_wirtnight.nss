int StartingConditional()
{
object oPC = GetPCSpeaker();

if (!(GetLocalInt(oPC, "wirthome") == 1)) return FALSE;

return TRUE;
}

