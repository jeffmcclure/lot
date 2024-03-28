//#include "inc_party"
void main()
{

object oPC = GetPCSpeaker();
AddJournalQuestEntry("QST_TKRON", 2, oPC, FALSE, FALSE);
SetLocalInt(oPC, "tkrontalk", 2);

}

