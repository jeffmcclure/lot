void main()
{

object oPC = GetPCSpeaker();

object oItem;
oItem = GetItemPossessedBy(oPC, "D1_GRAYSUIT");

if (GetIsObjectValid(oItem))
   DestroyObject(oItem);

}
