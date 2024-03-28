int StartingConditional()
{
object oPC = GetPCSpeaker();

if (!(GetLocalInt(oPC, "sinwar") == 1)) return FALSE;

return TRUE;
}

