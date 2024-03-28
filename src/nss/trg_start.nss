#include "inc_party"
#include "nw_i0_tool"
void main() {
    object oPC = GetPCSpeaker();
    string sTag=GetTag(OBJECT_SELF);
    SetPartyInt(oPC, sTag, 1);
    AddJournalQuestEntry("QST_MAINMODULE", 1, oPC, TRUE, FALSE);

    // end_virgin.nss will give xp, so don't double up here
    //RewardPartyXP(251, oPC, TRUE);

    //object oMember = GetFirstFactionMember(oPC, TRUE);

    AddJournalQuestEntry("QST_WELCOME_BACK", 1, oPC, FALSE, FALSE); // only give to player not party

    if (GetItemPossessedBy(oPC, "CloakofFastFeet") == OBJECT_INVALID) {
        RewardPartyGP(500, oPC, FALSE);

        CreateItemOnObject("nw_it_mpotion002", oPC);
        CreateItemOnObject("nw_it_mpotion020", oPC);
        CreateItemOnObject("nw_it_mpotion001", oPC);
        CreateItemOnObject("nw_it_mpotion003", oPC);
        CreateItemOnObject("nw_it_mpotion021", oPC);
        CreateItemOnObject("nw_it_spdvscr501", oPC);
        CreateItemOnObject("nw_it_spdvscr702", oPC);
        CreateItemOnObject("nw_it_medkit001", oPC);

        /*
         * Cloak of Fast Feet
         */
        object obj = CreateItemOnObject("cloakoffastfeet", oPC, 1, "CloakofFastFeet"); // Cloak of Fast Feet
        SetIdentified(obj,TRUE);
        SetPlotFlag(obj, TRUE);  // set resale value to zero
        DelayCommand(0.5, AssignCommand(oPC, ActionEquipItem(obj, INVENTORY_SLOT_CLOAK)));
    }

    //CreateItemOnObject("nw_wmgmrd002", oPC); // Wand of Resurrection
    //CreateItemOnObject("start_container", oPC);
    //CreateItemOnObject("rodofhealing", oPC);
}
