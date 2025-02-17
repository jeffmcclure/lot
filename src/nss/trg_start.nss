#include "inc_party"
#include "nw_i0_tool"
void main() {
    object oPC = GetPCSpeaker();
    string sTag=GetTag(OBJECT_SELF); // OBJECT_SELF is the NPC we are talking to; GetTag() returns "NPC_THEEMON" for example
    SetLocalInt(oPC, sTag, 1);

    AddJournalQuestEntry("QST_MAINMODULE", 1, oPC, FALSE, FALSE); // only give to player not party

    int nInt = GetLocalInt(oPC, "NW_JOURNAL_ENTRYQST_WELCOME_BACK");
    if (nInt > 0) return;

    AddJournalQuestEntry("QST_WELCOME_BACK", 1, oPC, FALSE, FALSE); // only give to player not party

    if (GetItemPossessedBy(oPC, "cloakoffastfe") != OBJECT_INVALID) return; // only allow one time

    //RewardPartyGP(500, oPC, FALSE); // reward just player, not party

    CreateItemOnObject("nw_it_mpotion002", oPC);
    CreateItemOnObject("nw_it_mpotion020", oPC);
    CreateItemOnObject("nw_it_mpotion001", oPC);
    CreateItemOnObject("nw_it_mpotion003", oPC);
    CreateItemOnObject("nw_it_mpotion021", oPC);
    //CreateItemOnObject("nw_it_spdvscr501", oPC); // raise dead scroll
    //CreateItemOnObject("nw_it_spdvscr702", oPC); // resurrection scroll
    CreateItemOnObject("nw_it_medkit001", oPC);

    /*
     * Cloak of Fast Feet
     */
    object obj = CreateItemOnObject("cloakoffastfe", oPC, 1, "cloakoffastfe"); // Cloak of Fast Feet

        //effect eGoFast = EffectMovementSpeedIncrease(50);
        //ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGoFast, obj);

            //itemproperty ipAddFeat = ItemPropertyBonusFeat(IP_CONST_FEAT_KNOCKDOWN);
            //itemproperty ipAddFeat = ItemPropertyBonusFeat(FEAT_BARBARIAN_ENDURANCE);

            //itemproperty ipAddFeat = ItemPropertyBonusFeat(53);
            //AddItemProperty(DURATION_TYPE_PERMANENT, ipAddFeat, obj);
            //ipAddFeat = ItemPropertyBonusFeat(54);
            //AddItemProperty(DURATION_TYPE_PERMANENT, ipAddFeat, obj);

    SetIdentified(obj,TRUE);
    SetPlotFlag(obj, TRUE);  // set resale value to zero
    DelayCommand(0.5, AssignCommand(oPC, ActionEquipItem(obj, INVENTORY_SLOT_CLOAK)));

    //CreateItemOnObject("nw_wmgmrd002", oPC); // Wand of Resurrection
    //CreateItemOnObject("start_container", oPC);
    //CreateItemOnObject("rodofhealing", oPC);
}
