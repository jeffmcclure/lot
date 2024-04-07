void DestroyIfEmptyV1(object creature) {
    //SendMessageToPC(GetFirstPC(), "DestroyIfEmpty()");
    SetIsDestroyable(TRUE, FALSE, FALSE);

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
    if (!any) DestroyObject(creature);
}

void DestroyIfEmptyV2() {
    //SendMessageToPC(GetFirstPC(), "destroy_if_empty ENTER");
    SetIsDestroyable(TRUE, FALSE, FALSE);

    if (!GetIsObjectValid(GetFirstItemInInventory(OBJECT_SELF)) && GetGold(OBJECT_SELF) < 1) {
        //SendMessageToPC(GetFirstPC(), "destroy_if_empty DESTROY");
        DestroyObject(OBJECT_SELF);
    }
}

void main() {
    DestroyIfEmptyV1(OBJECT_SELF);
}
