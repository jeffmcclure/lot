#include "loot_inc_gen_mod"
// For each item in the container, re-create a copy for each player and destroy the original item

void main() {
    if (GetLocalInt(OBJECT_SELF, "ONCE") > 0) return;
    SetLocalInt(OBJECT_SELF, "ONCE", 1);

    // destroy container contents and create properties
    object oItem = GetFirstItemInInventory(OBJECT_SELF);
    int loop = 0;
    while (GetIsObjectValid(oItem)) {
        string resref = GetResRef(oItem);
        SetLocalString(OBJECT_SELF, "loot" + IntToString(loop), resref);
        DestroyObject(oItem);
        oItem = GetNextItemInInventory(OBJECT_SELF);
        loop = loop + 1;
    }

    // create per-player loot based on above created properties
    PopulateLootForParty(GetLastOpenedBy(), OBJECT_SELF);
}
