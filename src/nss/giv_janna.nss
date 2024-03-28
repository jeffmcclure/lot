//#include "inc_party"
void main()
{

object oPC = GetPCSpeaker();
AddJournalQuestEntry("QST_JANNA", 1, oPC, FALSE, FALSE);
SetLocalInt(oPC, "jannatalk", 1);

}

