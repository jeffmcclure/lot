#include "loot_inc_gen_mod"

void main() {
    MoveInventoryLootToProperties();

    // create per-player loot based on above created properties
    PopulateLootForParty(OBJECT_SELF, GetLastOpenerOrKiller());
}
