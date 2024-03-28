//#include "inc_party"
void main()
{

object oPC = GetPCSpeaker();
AddJournalQuestEntry("QST_JARULF", 1, oPC, FALSE, FALSE);
SetLocalInt(oPC, "jarulftalk", 1);

}

