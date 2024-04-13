#include "loot_inc_gen_mod"

void main() {
    TreasureChestBook();
    MoveInventoryLootToProperties();
    PopulateLootForParty(OBJECT_SELF, GetLastOpenerOrKiller());
}
