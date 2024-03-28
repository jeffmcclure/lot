#include "inc_party"
#include "nw_i0_tool"
void main()
{

object oPC = GetPCSpeaker();
string sTag=GetTag(OBJECT_SELF);
SetPartyInt(oPC, sTag, 1);
AddJournalQuestEntry("QST_MAINMODULE", 1, oPC, TRUE, FALSE);

RewardPartyGP(1000, oPC, TRUE);
RewardPartyXP(251, oPC, TRUE);

object oMember=GetFirstFactionMember(oPC, TRUE);

while (GetIsObjectValid(oMember)) {
    CreateItemOnObject("nw_it_mpotion002", oMember);
    CreateItemOnObject("nw_it_mpotion020", oMember);
    CreateItemOnObject("nw_it_mpotion001", oMember);
    CreateItemOnObject("nw_it_mpotion003", oMember);
    CreateItemOnObject("nw_it_mpotion021", oMember);
    CreateItemOnObject("nw_it_spdvscr501", oMember);
    CreateItemOnObject("nw_it_spdvscr702", oMember);
    CreateItemOnObject("nw_it_medkit001", oMember);

    /*
     * Cloak of Fast Feet
     */
    object obj = CreateItemOnObject("cloakoffastfeet", oMember); // Cloak of Fast Feet
    SetIdentified(obj,TRUE);
    SetPlotFlag(obj, TRUE);  // set resale value to zero
    DelayCommand(0.5, AssignCommand(oMember, ActionEquipItem(obj, INVENTORY_SLOT_CLOAK)));

    //CreateItemOnObject("nw_it_mboots005", oMember); // Boots of Speed

    oMember=GetNextFactionMember(oPC, TRUE);
}
//CreateItemOnObject("nw_wmgmrd002", oPC); // Wand of Resurrection

//CreateItemOnObject("start_container", oPC);
//CreateItemOnObject("rodofhealing", oPC);

}

