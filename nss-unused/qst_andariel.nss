int StartingConditional()
{
object oPC = GetPCSpeaker();

if (!(GetLocalInt(oPC, "andariel") > 0)) return FALSE;
if (!(GetLocalInt(oPC, "andariel") < 5)) return FALSE;

return TRUE;
}

