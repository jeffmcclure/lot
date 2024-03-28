void main()
{

object oPC = GetPCSpeaker();

object oItem;
oItem = GetItemPossessedBy(oPC, "D1_CORPSEROOF");

if (GetIsObjectValid(oItem))
   DestroyObject(oItem);

oItem = GetItemPossessedBy(oPC, "D1_CORPSEINNEAS");

if (GetIsObjectValid(oItem))
   DestroyObject(oItem);

//SendMessageToPC(oPC, "The corpses of the two men magically disappear!  What's going on here!");

}
