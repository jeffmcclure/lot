void main()
{

object oPC = GetClickingObject();
if (!GetIsPC(oPC)) return;

FloatingTextStringOnCreature("You came here for a reason, why do you want to leave?", oPC);

}

