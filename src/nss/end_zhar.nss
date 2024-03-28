#include "NW_I0_GENERIC"
void main()
{
    object oPC = GetPCSpeaker();
    SetIsTemporaryEnemy(GetPCSpeaker());
    DetermineCombatRound();
}
