void DestroyIfEmptyV1(object creature) {
    int jeffloot = GetLocalInt(creature, "JEFF_LOOT");
    SendMessageToPC(GetFirstPC(), "DestroyIfEmpty() ENTER " + GetName(creature) + " JEFF_LOOT:" + IntToString(jeffloot));
    if (jeffloot) return;

    object oItem = GetFirstItemInInventory(creature);
    int any = FALSE;
    while (OBJECT_INVALID != oItem) {
        SendMessageToPC(GetFirstPC(), "Destroy x");
        string resref = GetResRef(oItem);
        int droppable = GetDroppableFlag(oItem);
        if (droppable) {
            any = TRUE;
            //return;
        }
        SendMessageToPC(GetFirstPC(), "Destroy " + GetLocalString(oItem, "LIMIT_ACQUIRE") + " Destroy " + IntToString(GetLocalInt(oItem, "JEFF_LOOT")));
        if (GetLocalInt(oItem, "JEFF_LOOT") > 0) {
            any = TRUE;
            //return;
        }
        //SendMessageToPC(GetFirstPC(), "DEAD ITEM " + GetName(oItem) + " drop:" + IntToString(droppable));
        oItem = GetNextItemInInventory(OBJECT_SELF);
    }

    int i;
    for (i = 0; i < NUM_INVENTORY_SLOTS; ++i) {
        oItem = GetItemInSlot(i, creature);
        if (GetIsObjectValid(oItem)) {
            SendMessageToPC(GetFirstPC(), "valid " + GetName(oItem));
        } else {
            SendMessageToPC(GetFirstPC(), "invalid");
        }
    }

    int gold = GetGold(creature);

    if (gold > 0) {
        any = TRUE;
        //return;
        //SendMessageToPC(GetFirstPC(), "DEAD GOLD " + IntToString(gold));
    }

    //if (!any) SetUseableFlag(creature, FALSE);

    SendMessageToPC(GetFirstPC(), "Destroy: " + IntToString(any));
    if (any) return;

    SetUseableFlag(OBJECT_SELF, FALSE);
    DestroyObject(creature);
    SetIsDestroyable(TRUE, FALSE, FALSE);
}

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
