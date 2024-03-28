#include "inc_party"
void main()
{

object oPC = GetPCSpeaker();
SetPartyInt(oPC, "nakruljournal1", 1);
AddJournalQuestEntry("QST_NAKRUL", 1, oPC, TRUE, FALSE);

}

