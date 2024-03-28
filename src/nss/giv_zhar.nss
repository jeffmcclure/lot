void main()
{

object oPC = GetPCSpeaker();
CreateItemOnObject("nw_it_sparscr906", oPC);
CreateItemOnObject("nw_it_sparscr607", oPC);
CreateItemOnObject("nw_it_sparscr507", oPC);
CreateItemOnObject("scrolloftownport", oPC);
AddJournalQuestEntry("QST_ZHAR", 1, oPC, TRUE, FALSE);
SetLocalInt(oPC, "zhar", 2);

}
