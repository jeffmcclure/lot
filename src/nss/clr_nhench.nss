void main()
{

object oPC = GetExitingObject();
if (!GetIsPC(oPC)) return;
SetLocalInt(oPC, "nHench", 0);

}
