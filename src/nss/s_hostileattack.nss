#include "NW_I0_GENERIC"
void main()
{

object oTarget;
oTarget = OBJECT_SELF;
ChangeToStandardFaction(oTarget, STANDARD_FACTION_HOSTILE);
SetIsTemporaryEnemy(GetPCSpeaker());
DetermineCombatRound();

}
