void main()
{
object oPC = GetLastDisturbed();

if (!GetIsPC(oPC)) return;

SetLocalInt(oPC, "rackweapon", 1);

}
