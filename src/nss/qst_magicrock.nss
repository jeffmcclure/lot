#include "pqj_inc"
void main()
{

object oPC = GetPCSpeaker();
AddPersistentJournalQuestEntry("QST_MAGICROCK", 1, oPC, TRUE, FALSE);

}

