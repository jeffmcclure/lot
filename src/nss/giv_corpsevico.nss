void main()
{

object oPC = GetPCSpeaker();

object oItem;
oItem = GetItemPossessedBy(oPC, "corpsevico");

if (GetIsObjectValid(oItem))
   DestroyObject(oItem);

}
