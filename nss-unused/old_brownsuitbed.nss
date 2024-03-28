#include "inc_party"
void main()
{

object oPC = GetLastOpenedBy();
if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_COW");
if (nInt < 2)
   {
   if (GetItemPossessedBy(oPC, "D1_BROWNSUIT")== OBJECT_INVALID)
      {
      nInt=GetPartyInt(oPC, "brownsuitbed");
      if (nInt == 0)
         {
          CreateItemOnObject("thebrownsuit001", OBJECT_SELF);
          SetPartyInt(oPC, "brownsuitbed", 1);
         }
      }
   }
}
