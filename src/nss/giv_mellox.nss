//#include "inc_party"
void main()
{

object oPC = GetPCSpeaker();
AddJournalQuestEntry("QST_MELLO", 2, oPC, FALSE, FALSE);
SetLocalInt(oPC, "mellotalk", 2);

}

