#include "nw_i0_tool"
void main()
{

object oPC = GetPCSpeaker();

object oItem;
oItem = GetItemPossessedBy(oPC, "D1_AZUREWRATH");

if (GetIsObjectValid(oItem))
   DestroyObject(oItem);

RewardPartyGP(2000000, oPC, TRUE);
SetLocalInt(oPC, "azuregone", 1);

}
