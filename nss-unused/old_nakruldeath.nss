#include "nw_i0_tool"
void main()
{

object oPC = GetFirstPC();

object oTarget;
oTarget = GetObjectByTag("D1_GRAVESTONE");
CreateItemOnObject("stoneofjordan", oTarget);

AddJournalQuestEntry("QST_NAKRUL", 4, oPC, TRUE, FALSE);
RewardPartyXP(2000, oPC, TRUE);

oTarget = GetObjectByTag("SND_NAKRULROAR");
SoundObjectStop(oTarget);

}
