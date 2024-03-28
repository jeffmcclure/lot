#include "69_inc_henai"
// the henchman targets the closest Enemy with the spell

void main()
{
    SetLocalObject(OBJECT_SELF, "Henchman_Spell_Target", GetNearestSeenOrHeardEnemy());
}
