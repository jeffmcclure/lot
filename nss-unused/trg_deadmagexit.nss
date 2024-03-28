#include "nw_i0_spells"

void main()
{
object oPC = GetExitingObject();
RemoveSpecificEffect(EFFECT_TYPE_SPELL_FAILURE, oPC);
}
