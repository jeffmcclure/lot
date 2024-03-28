void main()
{

object oPC = GetPCSpeaker();

CreateItemOnObject("zephyr", oPC);

SetLocalInt(oPC, "rackweapon", 1);

}

