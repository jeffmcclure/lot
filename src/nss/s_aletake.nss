void main()
{

object oPC = GetPCSpeaker();

object oItem;
oItem = GetItemPossessedBy(oPC, "NW_IT_MPOTION021");

if (GetIsObjectValid(oItem))
   DestroyObject(oItem);

}

