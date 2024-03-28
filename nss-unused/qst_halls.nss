int StartingConditional()
{
object oPC = GetPCSpeaker();

if (!(GetLocalInt(oPC, "blind") > 0)) return FALSE;
if (!(GetLocalInt(oPC, "blind") < 5)) return FALSE;

return TRUE;
}

