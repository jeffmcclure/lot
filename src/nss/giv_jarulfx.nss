//#include "inc_party"
void main()
{

object oPC = GetPCSpeaker();
AddJournalQuestEntry("QST_JARULF", 2, oPC, FALSE, FALSE);
SetLocalInt(oPC, "jarulftalk", 2);

}

