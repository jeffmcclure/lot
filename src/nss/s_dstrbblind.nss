void main()
{
object oPC = GetLastDisturbed();

if (!GetIsPC(oPC)) return;

SetLocalInt(oPC, "blind", 5);

}
