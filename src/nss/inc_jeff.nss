#include "x2_inc_itemprop"
#include "nw_i0_plot"

void MessageAll(string sMessage) {
    object oPlayer = GetFirstPC();
    while(GetIsObjectValid(oPlayer)) {
        SendMessageToPC(oPlayer,sMessage);
        oPlayer = GetNextPC();
    }
}

int hasItem2(object oPC, string itemTag) {
    object cloak = GetItemInSlot(INVENTORY_SLOT_CLOAK, oPC);
    if (GetIsObjectValid(cloak) && itemTag == GetTag(cloak)) {
        return TRUE;
    }

    object oItem = GetFirstItemInInventory(oPC);
    while (GetIsObjectValid(oItem)) {
        if (itemTag == GetTag(oItem)) {
            return TRUE;
        }
        //SendMessageToPC(oPC, GetName(oItem));
        //SendMessageToPC(oPC, GetTag(oItem));
        oItem = GetNextItemInInventory(oPC);
    }

    return FALSE;
}

void JeffGiveStuff(object oPC) {
    if (!GetIsPC(oPC)) return;

    /*
     * Wand of Resurrection
     */
    if (HasItem(oPC, "NW_WMGMRD002") == FALSE) {
        object obj = CreateItemOnObject("nw_wmgmrd002", oPC); // wand of resurrection
        SetIdentified(obj,TRUE);
        SetPlotFlag(obj, TRUE); // set resale value to zero
        SetItemCursedFlag(obj, TRUE); // don't allow dropping, selling, trading
    } else {
        object obj = GetItemPossessedBy(oPC, "NW_WMGMRD002" );
        if (obj == OBJECT_INVALID) {
            return;
        }
        SetItemCharges(obj, 99);
    }

    /*
     * Cloak of Fast Feet
     */
    if (HasItem(oPC, "CloakofFastFeet") == FALSE) {
        object obj = CreateItemOnObject("cloakoffastfeet", oPC); // Cloak of Fast Feet
        SetIdentified(obj,TRUE);
        SetPlotFlag(obj, TRUE);  // set resale value to zero
        DelayCommand(0.5, AssignCommand(oPC, ActionEquipItem(obj, INVENTORY_SLOT_CLOAK)));
    }

    /*
     * Rectory Key
     */
    object door = GetObjectByTag("InsideRectoryDoor");
    if (GetIsObjectValid(door) && GetLocked(door) && !HasItem(oPC, "KEY_RECTORY_INSIDE")) {
        CreateItemOnObject("rectorykey", oPC);
    }

    /*
     * Tome of Town Portal
     */
    if (!HasItem(oPC, "ITM_BookOfTownPortal")) {
        object obj = CreateItemOnObject("bookoftownportal", oPC); // Tome of Town Portal w/10 uses
        //MessageAll(GetTag(obj));
        //MessageAll(GetName(obj));
        //MessageAll(GetResRef(obj));
        //SetTag(obj, "LOT_BOOK_OF_TOWN_PORTAL");
        SetItemCursedFlag(obj, TRUE); // don't allow dropping, selling, trading
    }
}

void JeffCreateObjectOnAllPartyMembers(
    string sItemTemplate,
    int nStackSize = 1,
    string sNewTag = "",
    int bIdentified = TRUE,
    int bPlotFlag = FALSE)
{
    object oPC = GetPCSpeaker();
    object oMember=GetFirstFactionMember(oPC, TRUE);

    while (GetIsObjectValid(oMember)) {
        object obj = CreateItemOnObject(sItemTemplate, oMember, nStackSize, sNewTag);
        SetIdentified(obj, bIdentified);
        SetPlotFlag(obj, bPlotFlag);  // if true set resale value to zero
        //DelayCommand(0.5, AssignCommand(oMember, ActionEquipItem(obj, INVENTORY_SLOT_CLOAK)));
        oMember=GetNextFactionMember(oPC, TRUE);
    }
}

void DestroyAllByTag(string sTag) {
    object oPC = GetFirstPC();
    object oMember = GetFirstFactionMember(oPC, TRUE);
    while (GetIsObjectValid(oMember)) {
        object oTarget = GetItemPossessedBy(oMember, sTag);
        if (GetIsObjectValid(oTarget)) {
            DestroyObject(oTarget, 0.5);
        }
        oMember = GetNextFactionMember(oPC, TRUE);
    }
}
