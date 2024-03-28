void main()
{

object oPC = GetPCSpeaker();

CreateItemOnObject("zephyr002", oPC);

SetLocalInt(oPC, "rackweapon", 1);

}

