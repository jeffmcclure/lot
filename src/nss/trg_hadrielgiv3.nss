void main()
{

object oPC = GetPCSpeaker();

object oItem;
oItem = GetItemPossessedBy(oPC, "D1_AZUREWRATH");

if (GetIsObjectValid(oItem))
   DestroyObject(oItem);

CreateItemOnObject("spectralelixir_x", oPC);
CreateItemOnObject("spectralelixir_x", oPC);
SetLocalInt(oPC, "azuregone", 1);

}
