void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetLocalInt(oPC, "lazarus");

if (!(nInt <= 1))
   return;

SetLocalInt(oPC, "lazarus", 1);

}

