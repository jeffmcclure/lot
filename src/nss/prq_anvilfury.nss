int StartingConditional()
{
object oPC = GetPCSpeaker();

if (!(GetLocalInt(oPC, "anvilquest") < 5)) return FALSE;

return TRUE;
}
