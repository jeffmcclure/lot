void main()
{
object oPC = GetLastDisturbed();

if (!GetIsPC(oPC)) return;

SetLocalInt(oPC, "bonechest2", 1);

}
