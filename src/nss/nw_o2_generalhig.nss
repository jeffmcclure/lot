#include "loot_inc_gen_mod"

void main() {
    TreasureChestHigh();
    MoveInventoryLootToProperties();
    PopulateLootForParty(OBJECT_SELF, GetLastOpenerOrKiller());
    ShoutDisturbed();
}
