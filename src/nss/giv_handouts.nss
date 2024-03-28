#include "nw_i0_tool"
void main()
{

object oPC = GetPCSpeaker();

RewardPartyGP(700, oPC, TRUE);
CreateItemOnObject("savestone", oPC);
CreateItemOnObject("dmfi_pc_emote", oPC);
CreateItemOnObject("modulemanual", oPC);
SetLocalInt(oPC, "startmodule", 1);

}
