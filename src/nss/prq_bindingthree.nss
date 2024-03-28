int StartingConditional()
{
object oPC = GetPCSpeaker();

if (!(GetLocalInt(oPC, "bindingthree") == 1)) return FALSE;

return TRUE;
}

