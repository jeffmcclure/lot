void main()
{

object oPC = GetPCSpeaker();

CreateItemOnObject("venom", oPC);

SetLocalInt(oPC, "rackweapon", 1);

}

