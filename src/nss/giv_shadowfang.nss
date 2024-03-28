#include "inc_party"
void main()
{

object oPC = GetPCSpeaker();
AddJournalQuestEntry("QST_SHADOWFANG", 1, oPC, TRUE, FALSE);
SetPartyInt(oPC, "fleshdone", 1);

}

