#include "loot_inc_gen_mod"

void main() {
    //SendMessageToPC(GetFirstPC(), "nw_02_generalmed");
    TreasureChestMedium();
    MoveInventoryLootToProperties();
    PopulateLootForParty(OBJECT_SELF, GetLastOpenerOrKiller());
    ShoutDisturbed();
}
