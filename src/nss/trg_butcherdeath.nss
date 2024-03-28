//#include "pqj_inc"
#include "nw_i0_tool"
string sDeny;
void main()
{

object oPC = GetFirstPC();

//int nInt;
//nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYQST_BUTCHER");

//if (!(nInt >= 1))
//   return;

//nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYQST_BUTCHER");

//if (!(nInt < 2))
//   {
//   sDeny="You have already done this quest!";

//   SendMessageToPC(oPC, sDeny);

//   return;
//   }

RewardPartyXP(750, oPC, TRUE);
//RewardPartyGP(500, oPC, TRUE);
//CreateItemOnObject("butcherscleaver", oPC);
//AddPersistentJournalQuestEntry("QST_BUTCHER", 2, oPC, FALSE, FALSE);
AddJournalQuestEntry("QST_BUTCHER", 2, oPC, TRUE, FALSE);
//ExecuteScript("sav_lastkilled", OBJECT_SELF);
AssignCommand(oPC, ActionSpeakString("The spirits of the dead are now avenged..."));
//SendMessageToPC(oPC, "The spirits of the dead are now avenged...");

object oTarget;
oTarget = GetObjectByTag("D1_WOUNDEDMAN");
DestroyObject(oTarget, 0.0);
oTarget = GetObjectByTag("BUTCHER_BLOOD");
DestroyObject(oTarget, 0.0);

oTarget = GetObjectByTag("SND_BUTCHER1");
SoundObjectStop(oTarget);
oTarget = GetObjectByTag("SND_BUTCHER2");
SoundObjectStop(oTarget);

}
