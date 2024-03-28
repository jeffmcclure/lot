#include "loot_inc_data"
#include "loot_inc_main"
#include "loot_inc_gen_mod"
// #include "nw_o2_coninclude"
// Uncomment the above line if you would prefer to use the standard BioWare
// treasure scripts. If you do so delete the line that includes "loot_inc_gen_mod"

void main() {
    object oLastOpener = GetLastOpener();
    string charName = GetName(oLastOpener);

    if (GetLocalInt(OBJECT_SELF, "NW_DO_ONCE"+charName) != 0) {
        return;
    }

    SetLocalInt(OBJECT_SELF, "NW_DO_ONCE"+charName, 1);

    GenerateHighTreasure(oLastOpener, OBJECT_SELF);
}

