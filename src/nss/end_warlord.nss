//#include "pqj_inc"
#include "nw_i0_tool"
void main()
{

object oPC = GetExitingObject();

if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYQST_WARLORD");

if (!(nInt == 3))
   return;

RewardPartyXP(1000, oPC, TRUE);
RewardPartyGP(5000, oPC, FALSE);
//AddPersistentJournalQuestEntry("QST_WARLORD", 4, oPC, FALSE, FALSE);
AddJournalQuestEntry("QST_WARLORD", 4, oPC, TRUE, FALSE);
//ExecuteScript("sav_lastexit", OBJECT_SELF);

}
