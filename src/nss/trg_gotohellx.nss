#include "inc_party"
void main()
{

object oPC = GetPCSpeaker();
SetPartyInt(oPC, "diablokill", 1);

//object oItem;
//oItem = GetItemPossessedBy(oPC, "KEY_LAZARUS_STAFF");
//
//if (GetIsObjectValid(oItem))
//   DestroyObject(oItem);
//
ExecuteScript("trg_teleporthell", OBJECT_SELF);

}
