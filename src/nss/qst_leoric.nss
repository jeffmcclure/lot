#include "inc_party"
void main()
{

object oPC = GetPCSpeaker();
SetPartyInt(oPC, "leoricquest", 1);
AddJournalQuestEntry("QST_LEORIC", 1, oPC, TRUE, FALSE);

}
