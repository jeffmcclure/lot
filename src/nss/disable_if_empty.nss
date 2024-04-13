void DisableIfEmptyV1(object creature) {
    //SendMessageToPC(GetFirstPC(), "DisableIfEmpty()");

    object oItem = GetFirstItemInInventory(creature);
    int any = FALSE;
    while (GetIsObjectValid(oItem)) {
        string resref = GetResRef(oItem);
        int droppable = GetDroppableFlag(oItem);
        if (droppable) {
            any = TRUE;
        }
        //SendMessageToPC(GetFirstPC(), "DEAD ITEM " + GetName(oItem) + " drop:" + IntToString(droppable));
        oItem = GetNextItemInInventory(OBJECT_SELF);
    }

    int gold = GetGold(creature);

    if (gold > 0) {
        any = TRUE;
        //SendMessageToPC(GetFirstPC(), "DEAD GOLD " + IntToString(gold));
    }

    //if (!any) SetUseableFlag(creature, FALSE);
    if (!any)
        SetUseableFlag(OBJECT_SELF, FALSE);
}

void DisableIfEmptyV2() {
    //SendMessageToPC(GetFirstPC(), "disable_if_empty ENTER");

    if (!GetIsObjectValid(GetFirstItemInInventory(OBJECT_SELF)) && GetGold(OBJECT_SELF) < 1) {
        //SendMessageToPC(GetFirstPC(), "disable_if_empty DISABLE");
        SetUseableFlag(OBJECT_SELF, FALSE);
    }
}

// recommended use OnClosed event
void main() {
    //SendMessageToPC(GetFirstPC(), "disable_if_empty ENTER");
    DisableIfEmptyV1(OBJECT_SELF);
}
