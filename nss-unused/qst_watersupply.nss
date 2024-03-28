#include "inc_party"
void main()
{

object oPC = GetPCSpeaker();
SetPartyInt(oPC, "waterquest", 1);
AddJournalQuestEntry("QST_WATERSUPPLY", 1, oPC, TRUE, FALSE);

}
