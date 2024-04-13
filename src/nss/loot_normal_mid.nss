#include "loot_inc_gen_mod"

void main() {
    TreasureChestMedium();
    MoveInventoryLootToProperties();
    PopulateLootForParty(OBJECT_SELF, GetLastOpenerOrKiller());
    ShoutDisturbed();
}
