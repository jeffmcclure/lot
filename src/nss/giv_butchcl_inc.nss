#include "nw_i0_tool"
// Search the inventory of the PC talking; don't search by tag globally
// because other PCs can have the butchers cleaver with matching tag
object GetFirstObjectFromInventory(object oPC, string sItemTag) {

    // check inventory for item
    object oItem = GetFirstItemInInventory(oPC);
    while (GetIsObjectValid(oItem)) {
        if (GetTag(oItem) == sItemTag) {
            return oItem;
        }
        oItem = GetNextItemInInventory(oPC);
    }

    int i = 0;
    // check equipped items for item
    for (i = 0; i < NUM_INVENTORY_SLOTS; ++i) {
        object oItem = GetItemInSlot(i, oPC);
        if (GetIsObjectValid(oItem) && (GetTag(oItem) == sItemTag)) {
            return oItem;
        }
    }

    return OBJECT_INVALID;
}

void SellButcherCleaver(int amount, object oPC) {
    object oItem = GetItemPossessedBy(oPC, "D1_BUTCHERSCLEAVER");
    if (oItem != OBJECT_INVALID) {
        DestroyObject(oItem, 0.0);
        RewardPartyGP(amount, oPC, TRUE);
        AdjustAlignment(oPC, ALIGNMENT_CHAOTIC, 2);
    }
}
