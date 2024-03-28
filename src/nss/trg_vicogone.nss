object oItem;
void main()
{

object oPC = GetPCSpeaker();

if (GetItemPossessedBy(oPC, "D1_CORPSEVICO")!= OBJECT_INVALID)
   {
   oItem = GetItemPossessedBy(oPC, "D1_CORPSEVICO");
   if (GetIsObjectValid(oItem))
      DestroyObject(oItem);

   }
}
