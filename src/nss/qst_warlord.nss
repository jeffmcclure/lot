void main()
{

object oPC = GetPCSpeaker();
CreateItemOnObject("thesteeltome", oPC);
AddJournalQuestEntry("QST_WARLORD", 1, oPC, TRUE, FALSE);

}
