int StartingConditional()
{
    return GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND)) ||
        GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_LEFTHAND));
}
