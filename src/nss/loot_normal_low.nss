#include "loot_inc_gen_mod"

void main() {
    TreasureChestLow();
    MoveInventoryLootToProperties();
    PopulateLootForParty(OBJECT_SELF, GetLastOpenerOrKiller());
    ShoutDisturbed();
}
