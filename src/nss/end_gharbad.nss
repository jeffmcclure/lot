#include "NW_I0_GENERIC"
void main()
{
    object oPC = GetPCSpeaker();
    AddJournalQuestEntry("QST_GHARBAD", 2, oPC, TRUE, FALSE);

    SetIsTemporaryEnemy(GetPCSpeaker());
    DetermineCombatRound();
}
