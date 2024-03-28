int StartingConditional()
{
object oPC = GetPCSpeaker();

if (!(GetLocalInt(oPC, "horadrim") == 1)) return FALSE;

return TRUE;
}

