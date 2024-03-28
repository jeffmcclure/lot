//#include "inc_party"
#include "nw_i0_tool"
void main()
{

object oPC = GetPCSpeaker();
AssignCommand(oPC, TakeGoldFromCreature(500000, oPC, TRUE));
RewardPartyXP(1000, oPC, TRUE);
CreateItemOnObject("jarulfbelt", oPC);
AddJournalQuestEntry("QST_JARULF", 3, oPC, TRUE, FALSE);
SetLocalInt(oPC, "jarulftalk", 3);

object oTarget;
oTarget = GetObjectByTag("CAIN");
AdjustReputation(oPC, oTarget, 1);

}
