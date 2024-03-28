#include "inc_party"
#include "nw_i0_tool"
object oTarget;
void main()
{

//object oPC = GetLastKiller();
//while (GetIsObjectValid(GetMaster(oPC)))
//   {
//   oPC=GetMaster(oPC);
//   }
//if (!GetIsPC(oPC)) return;
object oPC = GetFirstPC();

int nInt;
nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_GRAVEMATTERS");
if (nInt >= 2)
   {
   oTarget = GetObjectByTag("D1_GRAVESTONE");
   CreateItemOnObject("stoneofjordan", oTarget);
   AddJournalQuestEntry("QST_NAKRUL", 4, oPC, TRUE, FALSE);
   RewardPartyXP(1500, oPC, TRUE);
   oTarget = GetObjectByTag("SND_NAKRULROAR");
   SoundObjectStop(oTarget);

   }
else
   {
   AddJournalQuestEntry("QST_NAKRUL", 4, oPC, TRUE, FALSE);
   RewardPartyXP(1500, oPC, TRUE);
   oTarget = GetObjectByTag("SND_NAKRULROAR");
   SoundObjectStop(oTarget);

   }

}
