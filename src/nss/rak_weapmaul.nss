void main()
{

object oPC = GetPCSpeaker();

CreateItemOnObject("wind", oPC);

SetLocalInt(oPC, "rackweapon", 1);

}

