//::///////////////////////////////////////////////
//:: Copyright (c) 2024 Jeff McClure
//:://////////////////////////////////////////////
/*
    Death script for boss configured to drop per-player loot
*/
//:://////////////////////////////////////////////
//:: Created By: Jeff McClure
//:: Created On: 2024-03-01
//:://////////////////////////////////////////////

#include "nw_i0_tool"

// use when you want to give a specific amount of xp (value stored in NCP variable) and
// drop specific items (stored in NCP variables).   All party members receive the XP, and
// the monster corpse is populated with a separate copy of each loot for each player,
// each player may only pick up their own loot.
void main() {
    object oPC = GetLastKiller();
    int xp = GetLocalInt(OBJECT_SELF, "xp");
    if (xp > 0) {
        RewardPartyXP(xp, oPC, TRUE);
    } else {
        ExecuteScript("xp_partyextra", OBJECT_SELF);
    }

    //object oItem = GetFirstItemInInventory(OBJECT_SELF);
    //while (GetIsObjectValid(oItem)) {
    //    SendMessageToPC(GetFirstPC(), "inv='" + GetResRef(oItem) + "'");
    //    oItem = GetNextItemInInventory(OBJECT_SELF);
    //}

    int i;
    int any = FALSE;
    for (i = 0; i < 5; i++) {
        string lootResRef = GetLocalString(OBJECT_SELF, "loot" + IntToString(i));
        if (lootResRef != "") {
            any = TRUE;
            object oMember = GetFirstFactionMember(oPC, TRUE);
            while (GetIsObjectValid(oMember)) {
                string charName = GetName(oMember);
                object obj = CreateItemOnObject(lootResRef, OBJECT_SELF);
                SetIdentified(obj, TRUE);
                SetLocalString(obj, "LIMIT_ACQUIRE", charName);
                oMember = GetNextFactionMember(oPC, TRUE);
            }
        }
    }

    if (!any) {
        ExecuteScript("loot_normal_hi", OBJECT_SELF);
    }
}
