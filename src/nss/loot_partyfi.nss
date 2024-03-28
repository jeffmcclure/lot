#include "loot_inc_gen_mod"
// For each item listed in the containers "loot" variables, loop through variables and create

void main() {
    if (GetLocalInt(OBJECT_SELF, "ONCE") > 0) return;
    SetLocalInt(OBJECT_SELF, "ONCE", 1);

    // create per-player loot based on container properties
    PopulateLootForParty(OBJECT_SELF, GetLastOpenerOrKiller());
}
