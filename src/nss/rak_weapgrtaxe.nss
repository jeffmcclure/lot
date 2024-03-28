void main()
{

object oPC = GetPCSpeaker();

CreateItemOnObject("beast", oPC);

SetLocalInt(oPC, "rackweapon", 1);

}

