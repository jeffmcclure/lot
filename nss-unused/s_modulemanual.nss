string sDeny;
void main()
{

object oPC = GetLastUsedBy();

if (!GetIsPC(oPC)) return;

if (GetItemPossessedBy(oPC, "D1_MODULEMANUAL")!= OBJECT_INVALID)
   {
   sDeny="You already have a guidebook.";

   SendMessageToPC(oPC, sDeny);

   return;
   }

CreateItemOnObject("modulemanual", oPC);

}
