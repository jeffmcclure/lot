#include "loot_inc_gen_mod"

void main() {
    //SendMessageToPC(GetFirstPC(), "loot_partyfi1");
    MoveInventoryLootToProperties();

    // create per-player loot based on above created properties
    PopulateLootForParty(OBJECT_SELF, GetLastOpenerOrKiller());
}
