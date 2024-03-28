void main()
{

object oPC = GetPCSpeaker();

CreateItemOnObject("zephyr003", oPC);

SetLocalInt(oPC, "rackweapon", 1);

}

