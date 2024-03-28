void main()
{
object oPC = GetLastDisturbed();

if (!GetIsPC(oPC)) return;

SetLocalInt(oPC, "hellforge", 5);

}
