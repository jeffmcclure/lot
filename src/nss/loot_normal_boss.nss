#include "loot_inc_gen_mod"

void main() {
    TreasureChestBoss();
    MoveInventoryLootToProperties();
    PopulateLootForParty(OBJECT_SELF, GetLastOpenerOrKiller());
    ShoutDisturbed();
}
