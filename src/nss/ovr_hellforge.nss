int StartingConditional()
{
object oPC = GetPCSpeaker();

if (!(GetLocalInt(oPC, "hellforge") == 5)) return FALSE;

return TRUE;
}

