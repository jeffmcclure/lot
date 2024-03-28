void main()
{

object oPC = GetPCSpeaker();
CreateItemOnObject("goldenelixir", oPC);
AddJournalQuestEntry("QST_LACHDANAN", 2, oPC, TRUE, FALSE);

}
