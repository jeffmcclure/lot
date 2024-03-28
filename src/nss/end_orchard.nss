#include "nw_i0_tool"
void main()
{

object oPC = GetPCSpeaker();
AddJournalQuestEntry("QST_ORCHARD", 2, oPC, TRUE, FALSE);
RewardPartyXP(750, oPC, TRUE);
CreateItemOnObject("auricamulet", oPC);

}

