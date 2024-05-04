#include "x2_inc_itemprop"
#include "nw_i0_plot"

int AutoDC3(int DC, int nSkill, object oTarget);

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
        //SetItemCursedFlag(obj, TRUE); // don't allow dropping, selling, trading
    } else {
        object obj = GetItemPossessedBy(oPC, "NW_WMGMRD002" );
        if (obj == OBJECT_INVALID) {
            return;
        }
        SetItemCharges(obj, 99);
    }

    /*
     * Rectory Key
     */
    object door = GetObjectByTag("InsideRectoryDoor");
    if (GetIsObjectValid(door) && GetLocked(door) && !HasItem(oPC, "KEY_RECTORY_INSIDE")) {
        CreateItemOnObject("rectorykey", oPC);
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

///////////////////////////////////////////////////////////////////////////////
//
//  AutoDC
//
///////////////////////////////////////////////////////////////////////////////
//  Returns a pass value based on the object's level and the suggested DC
// December 20 2001: Changed so that the difficulty is determined by the
// NPC's Hit Dice
// November 2002 (Brent): Adding a higher upper range for level 15+ campaigns.
// August 2003 (Georg): Fixed bug not adding up DCs in the correct order
///////////////////////////////////////////////////////////////////////////////
//  Created By: Brent, September 13 2001
///////////////////////////////////////////////////////////////////////////////
int AutoDC3(int DC, int nSkill, object oTarget)
{
    /*
    Easy = Lvl/4 ...rounded up
    Moderate = 3/Lvl + Lvl ...rounded up
    Difficult = Lvl * 1.5 + 6 ...rounded up
    */
    int nLevel = GetHitDice(OBJECT_SELF);
    int nTest = 0;

    // * July 2
    // * If nLevel is less than 0 or 0 then set it to 1
    if (nLevel <= 0)
    {
        nLevel = 1;
    }

    switch (DC)
    {
        case DC_EASY: nTest = nLevel / 4 + 1; break;
            // * minor tweak to lower the values a little
        case DC_MEDIUM: nTest = (3 / nLevel + nLevel) - abs( (nLevel/2) -2); break;
        case DC_HARD: nTest = FloatToInt(nLevel * 1.5 + 6) - abs( ( FloatToInt(nLevel/1.5) -2)); break;
        case DC_SUPERIOR: nTest = 7+ FloatToInt(nLevel * 1.5 + 6) - abs( ( FloatToInt(nLevel/1.5) -2)); break;
        case DC_MASTER: nTest = 14 + FloatToInt(nLevel * 1.5 + 6) - abs( ( FloatToInt(nLevel/1.5) -2)); break;
        case DC_LEGENDARY: nTest = 21 + FloatToInt(nLevel * 1.5 + 6) - abs( ( FloatToInt(nLevel/1.5) -2)); break;
        case DC_EPIC: nTest = 28 + FloatToInt(nLevel * 1.5 + 6) - abs( ( FloatToInt(nLevel/1.5) -2)); break;
    }



    // *********************************
    // * CHARM/DOMINATION
    // * If charmed or dominated the NPC
    // * will be at a disadvantage
    // *********************************
    int nCharmMod = 0;

    if (nSkill == SKILL_PERSUADE || nSkill == SKILL_BLUFF || nSkill == SKILL_INTIMIDATE)
        nCharmMod = GetNPCEasyMark(oTarget);
    int nDC = nTest + 10 - nCharmMod ;
    if (nDC < 1 )
        nDC = 1;

    int d20Roll = d20();
    int skillRank = GetSkillRank(nSkill, oTarget);
    string rollMessage = "(skillRank " + IntToString(skillRank) + ") + (d20 roll " + IntToString(d20Roll) + ") vs (DC " + IntToString(nDC) + ")";
    // * Roll d20 + skill rank vs. DC + 10
    if ((skillRank + d20Roll) >= nDC) {
       SendMessageToPC(oTarget, "SUCCESS " + rollMessage);
       return TRUE;
    } else {
       SendMessageToPC(oTarget, "FAIL " + rollMessage);
       return FALSE;
    }
}