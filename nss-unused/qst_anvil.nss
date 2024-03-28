int StartingConditional()
{
object oPC = GetPCSpeaker();

if (!(GetLocalInt(oPC, "anvil") > 0)) return FALSE;
if (!(GetLocalInt(oPC, "anvil") < 5)) return FALSE;

return TRUE;
}

