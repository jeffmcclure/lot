void main()
{
object oPC = GetLastDisturbed();

if (!GetIsPC(oPC)) return;

SetLocalInt(oPC, "hell3chest", 5);

}
