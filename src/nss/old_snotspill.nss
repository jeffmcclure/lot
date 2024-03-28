#include "NW_I0_GENERIC"
void main()
{
    object oPC = GetPCSpeaker();
    AddJournalQuestEntry("QST_MAGICBANNER", 2, oPC, TRUE, FALSE);
    AddJournalQuestEntry("QST_OGDENSIGN", 2, oPC, TRUE, FALSE);
    SetIsTemporaryEnemy(GetPCSpeaker());
    DetermineCombatRound();
}
