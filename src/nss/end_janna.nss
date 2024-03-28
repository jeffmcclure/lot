#include "inc_party"
#include "nw_i0_tool"
void main()
{

object oPC = GetPCSpeaker();
RewardPartyXP(1000, oPC, TRUE);
CreateItemOnObject("jannacloak", oPC);
AddJournalQuestEntry("QST_JANNA", 3, oPC, FALSE, FALSE);
SetPartyInt(oPC, "jannatalk", 3);

object oTarget;
oTarget = GetObjectByTag("CAIN");
AdjustReputation(oPC, oTarget, 1);

}
