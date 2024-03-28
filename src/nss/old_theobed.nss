#include "inc_party"
void main()
{

object oPC = GetLastOpenedBy();
if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_THEO");
if (nInt == 1)
   {
   if (GetItemPossessedBy(oPC, "D1_THEODORE")== OBJECT_INVALID)
      {
      nInt=GetPartyInt(oPC, "theobed");
      if (nInt == 0)
         {
          CreateItemOnObject("theodore", OBJECT_SELF);
          SetPartyInt(oPC, "theobed", 1);
         }
      }
   }
}
