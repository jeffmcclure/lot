void main()
{

object oPC = GetPCSpeaker();
SetLocalInt(oPC, "lazarusjournal1", 1);
CreateItemOnObject("lazarusjournal01", oPC);

}

