void main()
{

object oPC = GetPCSpeaker();
SetLocalInt(oPC, "lazarusjournal2", 1);
CreateItemOnObject("lazarusjournal02", oPC);

}

