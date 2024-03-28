void main()
{

object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;

if (GetItemPossessedBy(oPC, "D1_CATACOMBSTONE")!= OBJECT_INVALID)
   return;

CreateItemOnObject("catacombstone", oPC);

}

