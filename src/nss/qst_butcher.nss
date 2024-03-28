#include "inc_party"
void main()
{

object oPC = GetPCSpeaker();
SetPartyInt(oPC, "butcherquest", 1);
AddJournalQuestEntry("QST_BUTCHER", 1, oPC, TRUE, FALSE);

}
