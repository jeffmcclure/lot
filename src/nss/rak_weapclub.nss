void main()
{

object oPC = GetPCSpeaker();

CreateItemOnObject("black", oPC);

SetLocalInt(oPC, "rackweapon", 1);

}

