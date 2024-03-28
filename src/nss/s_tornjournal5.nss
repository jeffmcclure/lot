#include "inc_party"
void main()
{

object oPC = GetPCSpeaker();
SetPartyInt(oPC, "nakruljournal5", 1);
AddJournalQuestEntry("QST_NAKRUL", 2, oPC, TRUE, FALSE);

}

