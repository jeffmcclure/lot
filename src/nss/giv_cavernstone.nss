void main()
{

object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;

if (GetItemPossessedBy(oPC, "D1_CAVERNSTONE")!= OBJECT_INVALID)
   return;

CreateItemOnObject("cavernstone", oPC);

}

