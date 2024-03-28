void main()
{

object oPC = GetPCSpeaker();

CreateItemOnObject("doom", oPC);

SetLocalInt(oPC, "rackweapon", 1);

}

