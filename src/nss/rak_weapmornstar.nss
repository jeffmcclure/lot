void main()
{

object oPC = GetPCSpeaker();

CreateItemOnObject("strength", oPC);

SetLocalInt(oPC, "rackweapon", 1);

}

