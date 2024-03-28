void main()
{

object oPC = GetPCSpeaker();

object oItem;
oItem = GetItemPossessedBy(oPC, "NW_WSPMKA002");

if (GetIsObjectValid(oItem))
   DestroyObject(oItem);

object oTarget;
oTarget = GetObjectByTag("HENCH_MELLO");
CreateItemOnObject("mellokama", oTarget);

}

