int StartingConditional()
{
object oPC = GetPCSpeaker();

if (!(GetLocalInt(oPC, "arkainequest") < 5)) return FALSE;

return TRUE;
}
