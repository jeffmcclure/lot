int StartingConditional()
{
object oPC = GetPCSpeaker();

if (!(GetLocalInt(oPC, "hell3chest") == 5)) return FALSE;

return TRUE;
}

