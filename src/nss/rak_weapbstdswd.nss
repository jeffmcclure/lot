void main()
{

object oPC = GetPCSpeaker();

CreateItemOnObject("fury", oPC);

SetLocalInt(oPC, "rackweapon", 1);

}

