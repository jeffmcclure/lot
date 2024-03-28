#include "inc_party"
void main()
{

object oPC = GetPCSpeaker();

object oItem;
oItem = GetItemPossessedBy(oPC, "KEY_LAZARUS_STAFF");

if (GetIsObjectValid(oItem))
   DestroyObject(oItem);

SetPartyInt(oPC, "lazarusstaff", 1);
ExecuteScript("trg_teleportlaz", OBJECT_SELF);

}
