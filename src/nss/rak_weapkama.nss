void main()
{

object oPC = GetPCSpeaker();

CreateItemOnObject("chaos", oPC);

SetLocalInt(oPC, "rackweapon", 1);

}

