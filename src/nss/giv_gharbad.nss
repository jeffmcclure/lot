void main()
{

object oPC = GetPCSpeaker();
AddJournalQuestEntry("QST_GHARBAD", 1, oPC, TRUE, FALSE);
CreateItemOnObject("nw_it_mring001", oPC);

}
