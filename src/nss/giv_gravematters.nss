#include "inc_party"
void main()
{

object oPC = GetPCSpeaker();
AddJournalQuestEntry("QST_GRAVEMATTERS", 1, oPC, TRUE, FALSE);
SetPartyInt(oPC, "cathedralmap", 2);

}

