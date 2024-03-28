#include "nw_i0_tool"
void main()
{

object oPC = GetFirstPC();
//while (GetIsObjectValid(GetMaster(oPC)))
//   {
//   oPC=GetMaster(oPC);
//   }
//
//if (!GetIsPC(oPC)) return;

AddJournalQuestEntry("QST_ZHAR", 2, oPC, TRUE, FALSE);
RewardPartyXP(750, oPC, TRUE);
AssignCommand(oPC, ActionSpeakString("I'm sorry, did I ruin your concentration?"));

}
