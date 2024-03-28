void main()
{

object oPC = GetPCSpeaker();

CreateItemOnObject("malice", oPC);

SetLocalInt(oPC, "rackweapon", 1);

}

