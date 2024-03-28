void main()
{

object oPC = GetPCSpeaker();

CreateItemOnObject("steel", oPC);

SetLocalInt(oPC, "rackweapon", 1);

}

