#include "loot_inc_gen_mod"

void DestroyIfEmptyV1(object creature) {
    if (!IsEmpty(creature)) return;
    SetUseableFlag(OBJECT_SELF, FALSE);
    DestroyObject(creature);
    SetIsDestroyable(TRUE, FALSE, FALSE);
}

void DisableIfEmptyV1(object creature) {
    if (!IsEmpty(creature)) return;
    SetUseableFlag(OBJECT_SELF, FALSE);
}
