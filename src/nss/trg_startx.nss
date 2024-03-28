#include "inc_party"
#include "nw_i0_tool"
void main()
{

object oPC = GetPCSpeaker();
string sTag=GetTag(OBJECT_SELF);
SetPartyInt(oPC, sTag, 1);
RewardPartyXP(250, oPC, TRUE);
AddJournalQuestEntry("QST_MAINMODULE", 1, oPC, TRUE, FALSE);
//RewardPartyGP(1000, oPC, FALSE);
//CreateItemOnObject("nw_it_mpotion002", oPC);
//CreateItemOnObject("nw_it_mpotion020", oPC);
//CreateItemOnObject("nw_it_mpotion001", oPC);
//CreateItemOnObject("nw_it_mpotion003", oPC);
//CreateItemOnObject("nw_it_mpotion021", oPC);
//CreateItemOnObject("nw_it_spdvscr501", oPC);
//CreateItemOnObject("nw_it_spdvscr702", oPC);
//CreateItemOnObject("nw_it_medkit001", oPC);
//CreateItemOnObject("start_container", oPC);
//CreateItemOnObject("rodofhealing", oPC);

}

