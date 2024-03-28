#include "nw_i0_tool"
void main()
{

object oPC = GetFirstPC();

AddJournalQuestEntry("QST_SHADOWFANG", 3, oPC, TRUE, FALSE);
//AddJournalQuestEntry("QST_FLESHDOOM", 3, oPC, TRUE, FALSE);
RewardPartyXP(2000, oPC, TRUE);

}

