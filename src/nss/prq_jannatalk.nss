int StartingConditional()
{
object oPC = GetPCSpeaker();
if (!(GetLocalInt(oPC, "jannatalk") == 0)) return FALSE;

return TRUE;
}

