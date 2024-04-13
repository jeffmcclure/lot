#include "loot_inc_gen_mod"

void main() {
    TreasureChestUnique();
    MoveInventoryLootToProperties();
    PopulateLootForParty(OBJECT_SELF, GetLastOpenerOrKiller());
    ShoutDisturbed();
}
