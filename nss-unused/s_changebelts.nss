object oItem;
void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

if (GetItemPossessedBy(oPC, "nw_it_mbelt013")!= OBJECT_INVALID)
   {
   oItem = GetItemPossessedBy(oPC, "nw_it_mbelt013");

   if (GetIsObjectValid(oItem))
      DestroyObject(oItem);

   CreateItemOnObject("greatbeltbrawler", oPC);

   }
if (GetItemPossessedBy(oPC, "nw_it_mbelt014")!= OBJECT_INVALID)
   {
   oItem = GetItemPossessedBy(oPC, "nw_it_mbelt014");

   if (GetIsObjectValid(oItem))
      DestroyObject(oItem);

   CreateItemOnObject("greatbeltarcher", oPC);

   }
if (GetItemPossessedBy(oPC, "nw_it_mbelt012")!= OBJECT_INVALID)
   {
   oItem = GetItemPossessedBy(oPC, "nw_it_mbelt012");

   if (GetIsObjectValid(oItem))
      DestroyObject(oItem);

   CreateItemOnObject("greatbeltswords", oPC);

   }
}
