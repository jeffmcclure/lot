//#include "inc_party"
void main()
{

object oPC = GetPCSpeaker();
AddJournalQuestEntry("QST_JANNA", 2, oPC, FALSE, FALSE);
SetLocalInt(oPC, "jannatalk", 2);

}

