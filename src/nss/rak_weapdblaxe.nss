void main()
{

object oPC = GetPCSpeaker();

CreateItemOnObject("calltoarms", oPC);

SetLocalInt(oPC, "rackweapon", 1);

}

