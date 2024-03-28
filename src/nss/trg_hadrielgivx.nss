#include "nw_i0_tool"
void main()
{

object oPC = GetPCSpeaker();

object oItem;
oItem = GetItemPossessedBy(oPC, "D1_AZUREWRATH");

if (GetIsObjectValid(oItem))
   DestroyObject(oItem);

    int nHD = GetHitDice(oPC) + 1;
    int nNewXP = ((( nHD * ( nHD - 1) ) / 2 ) * 1000) + 1;
    SetXP(oPC, nNewXP);

RewardPartyGP(1000000, oPC, TRUE);
SetLocalInt(oPC, "azuregone", 1);

}
