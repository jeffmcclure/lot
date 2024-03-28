#include "loot_inc_gen_mod"

void main() {
    SendMessageToPC(GetFirstPC(), "loot_unique");
    //TreasureChestUnique(OBJECT_SELF, GetLastOpenedBy());
    TreasureChestUnique(OBJECT_SELF, OBJECT_SELF);
}
