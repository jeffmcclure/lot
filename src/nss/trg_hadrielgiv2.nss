void main()
{

object oPC = GetPCSpeaker();

object oItem;
oItem = GetItemPossessedBy(oPC, "D1_AZUREWRATH");

if (GetIsObjectValid(oItem))
   DestroyObject(oItem);

CreateItemOnObject("obsidianringzod", oPC);
SetLocalInt(oPC, "azuregone", 1);

}
