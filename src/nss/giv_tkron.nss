//#include "inc_party"
void main()
{

object oPC = GetPCSpeaker();
AddJournalQuestEntry("QST_TKRON", 1, oPC, FALSE, FALSE);
SetLocalInt(oPC, "tkrontalk", 1);

}

