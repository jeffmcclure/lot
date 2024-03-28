#include "inc_party"
void main()
{

object oPC = GetPCSpeaker();
CreateItemOnObject("nakrulnote004", oPC);
SetPartyInt(oPC, "nakrulnote4", 1);
AddJournalQuestEntry("QST_NAKRUL", 2, oPC, TRUE, FALSE);

}

