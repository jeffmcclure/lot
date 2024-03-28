void main()
{

object oPC = GetPCSpeaker();

CreateItemOnObject("memory", oPC);

SetLocalInt(oPC, "rackweapon", 1);

}

