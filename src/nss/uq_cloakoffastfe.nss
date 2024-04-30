#include "nw_i0_spells"

void main() {
    object oTarget = GetPCItemLastUnequippedBy();
    RemoveSpecificEffect(EFFECT_TYPE_MOVEMENT_SPEED_INCREASE, oTarget);
}
