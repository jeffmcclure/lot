#include "inc_party"
#include "nw_i0_tool"
void main()
{

object oPC = GetPCSpeaker();

object oItem;
oItem = GetItemPossessedBy(oPC, "shadowfang");

if (GetIsObjectValid(oItem))
   DestroyObject(oItem);

RewardPartyXP(1000, oPC, TRUE);
RewardPartyGP(1000, oPC, FALSE);
SetPartyInt(oPC, "endtremayne", 1);

}
