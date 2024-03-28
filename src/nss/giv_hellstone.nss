void main()
{

object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;

if (GetItemPossessedBy(oPC, "D1_HELLSTONE")!= OBJECT_INVALID)
   return;

CreateItemOnObject("hellstone", oPC);

}

