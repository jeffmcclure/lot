#include "nw_i0_tool"
void main()
{

object oPC = GetFirstPC();

//AddJournalQuestEntry("QST_SHADOWFANG", 3, oPC, TRUE, FALSE);
AddJournalQuestEntry("QST_FLESHDOOM", 3, oPC, TRUE, FALSE);
RewardPartyXP(2000, oPC, TRUE);

AssignCommand(GetObjectByTag("NPC_FLESHDOOM"), ActionSpeakString("Nooooo! I am Fleshdoom!  I cannot die!"));
DelayCommand(3.0, AssignCommand(oPC, ActionSpeakString("This creature does not possess the cursed demon blade - where is it?  I must tell Tremayne!")));

}

