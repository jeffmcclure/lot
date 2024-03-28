void main()
{

object oPC = GetPCSpeaker();

if (GetItemPossessedBy(oPC, "HenchmanHealKit")== OBJECT_INVALID)
   {
   CreateItemOnObject("henchmanhealkit", oPC);

   }
}

