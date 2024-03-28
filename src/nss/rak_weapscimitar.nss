void main()
{

object oPC = GetPCSpeaker();

CreateItemOnObject("silence", oPC);

SetLocalInt(oPC, "rackweapon", 1);

}

