#include "nw_i0_tool"
void main()
{

object oPC = GetPCSpeaker();

AddJournalQuestEntry("QST_LIGHTS", 2, oPC, TRUE, FALSE);
RewardPartyXP(750, oPC, TRUE);

object oTarget;
oTarget = GetObjectByTag("CAIN");
AdjustReputation(oPC, oTarget, 1);

}

