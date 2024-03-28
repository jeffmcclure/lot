int StartingConditional()
{
object oPC = GetPCSpeaker();

if (!(GetLocalInt(oPC, "angels") > 0)) return FALSE;
if (!(GetLocalInt(oPC, "angels") < 5)) return FALSE;

return TRUE;
}

